import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_models.dart';

class AppState extends ChangeNotifier {
  AppState._();

  static final AppState instance = AppState._();

  static const _carKey = 'car_profile';
  static const _maintenanceKey = 'maintenance_items';
  static const _fuelKey = 'fuel_entries';
  static const _historyKey = 'history_entries';
  static const _darkModeKey = 'dark_mode';

  bool isLoading = true;
  bool isDarkMode = false;
  CarProfile car = CarProfile(
    name: 'My Car',
    make: 'Toyota',
    model: 'Corolla',
    year: 2020,
    currentMileage: 82400,
  );
  List<MaintenanceItem> maintenanceItems = [];
  List<FuelEntry> fuelEntries = [];
  List<HistoryEntry> historyEntries = [];

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool(_darkModeKey) ?? false;

    final carJson = prefs.getString(_carKey);
    if (carJson != null) {
      car = CarProfile.fromMap(jsonDecode(carJson) as Map<String, dynamic>);
    }

    final maintenanceJson = prefs.getString(_maintenanceKey);
    if (maintenanceJson == null) {
      maintenanceItems = _defaultMaintenance(car.currentMileage);
      await _saveMaintenance();
    } else {
      maintenanceItems = decodeList(maintenanceJson)
          .map(MaintenanceItem.fromMap)
          .toList();
    }

    fuelEntries = decodeList(prefs.getString(_fuelKey))
        .map(FuelEntry.fromMap)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    historyEntries = decodeList(prefs.getString(_historyKey))
        .map(HistoryEntry.fromMap)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    isDarkMode = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, value);
  }

  Future<void> updateCar(CarProfile value) async {
    car = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_carKey, jsonEncode(car.toMap()));
  }

  Future<void> serviceItem({
    required MaintenanceItem item,
    required int mileage,
    required DateTime date,
    double? cost,
    String note = '',
  }) async {
    final index = maintenanceItems.indexWhere((e) => e.id == item.id);
    if (index < 0) return;
    maintenanceItems[index] = item.copyWith(
      lastServiceMileage: mileage,
      lastServiceDate: date,
    );
    historyEntries.insert(
      0,
      HistoryEntry(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: '${item.title} serviced',
        details: note.isEmpty ? 'Maintenance completed' : note,
        date: date,
        mileage: mileage,
        type: 'maintenance',
        cost: cost,
      ),
    );
    if (mileage > car.currentMileage) {
      car = car.copyWith(currentMileage: mileage);
      await updateCar(car);
    }
    notifyListeners();
    await _saveMaintenance();
    await _saveHistory();
  }

  Future<void> addFuel(FuelEntry entry) async {
    fuelEntries.insert(0, entry);
    historyEntries.insert(
      0,
      HistoryEntry(
        id: 'h_${entry.id}',
        title: 'Fuel added',
        details: '${entry.liters.toStringAsFixed(1)} L',
        date: entry.date,
        mileage: entry.mileage,
        type: 'fuel',
        cost: entry.totalCost,
      ),
    );
    if (entry.mileage > car.currentMileage) {
      car = car.copyWith(currentMileage: entry.mileage);
      await updateCar(car);
    }
    notifyListeners();
    await _saveFuel();
    await _saveHistory();
  }

  Future<void> deleteFuel(String id) async {
    fuelEntries.removeWhere((e) => e.id == id);
    historyEntries.removeWhere((e) => e.id == 'h_$id');
    notifyListeners();
    await _saveFuel();
    await _saveHistory();
  }

  Future<void> deleteHistory(String id) async {
    historyEntries.removeWhere((e) => e.id == id);
    notifyListeners();
    await _saveHistory();
  }

  int get goodCount => maintenanceItems
      .where((e) => e.status(car.currentMileage) == MaintenanceStatus.good)
      .length;
  int get dueSoonCount => maintenanceItems
      .where((e) => e.status(car.currentMileage) == MaintenanceStatus.dueSoon)
      .length;
  int get overdueCount => maintenanceItems
      .where((e) => e.status(car.currentMileage) == MaintenanceStatus.overdue)
      .length;

  int get healthScore {
    if (maintenanceItems.isEmpty) return 100;
    final score = ((goodCount + (dueSoonCount * .5)) /
            maintenanceItems.length *
            100)
        .round();
    return score.clamp(0, 100);
  }

  double get totalFuelCost =>
      fuelEntries.fold(0, (sum, entry) => sum + entry.totalCost);

  double? get averageConsumption {
    final full = fuelEntries.where((e) => e.fullTank).toList()
      ..sort((a, b) => a.mileage.compareTo(b.mileage));
    if (full.length < 2) return null;
    final distance = full.last.mileage - full.first.mileage;
    if (distance <= 0) return null;
    final liters = full.skip(1).fold<double>(0, (sum, e) => sum + e.liters);
    return liters / distance * 100;
  }

  Future<void> _saveMaintenance() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _maintenanceKey,
      encodeList(maintenanceItems.map((e) => e.toMap()).toList()),
    );
  }

  Future<void> _saveFuel() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _fuelKey,
      encodeList(fuelEntries.map((e) => e.toMap()).toList()),
    );
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _historyKey,
      encodeList(historyEntries.map((e) => e.toMap()).toList()),
    );
  }

  List<MaintenanceItem> _defaultMaintenance(int mileage) {
    final now = DateTime.now();
    return [
      _item('oil', 'Engine Oil', 'Protects the engine and reduces wear.',
          Icons.oil_barrel, 5000, 6, mileage - 4200, now, 5),
      _item('filter', 'Oil Filter', 'Keeps contaminants away from the engine.',
          Icons.filter_alt, 5000, 6, mileage - 4200, now, 5),
      _item('air', 'Air Filter', 'Supports clean airflow and fuel efficiency.',
          Icons.air, 15000, 12, mileage - 8000, now, 8),
      _item('tires', 'Tire Rotation', 'Helps tires wear evenly.', Icons.tire_repair,
          10000, 12, mileage - 6500, now, 7),
      _item('brakes', 'Brake Inspection', 'Checks pads, discs, and braking safety.',
          Icons.car_repair, 10000, 12, mileage - 9500, now, 11),
      _item('battery', 'Battery Check', 'Monitors battery condition and age.',
          Icons.battery_charging_full, 20000, 12, mileage - 5000, now, 10),
      _item('coolant', 'Coolant', 'Helps prevent overheating and corrosion.',
          Icons.device_thermostat, 30000, 24, mileage - 12000, now, 15),
      _item('transmission', 'Transmission Fluid', 'Supports smooth gear changes.',
          Icons.settings, 60000, 36, mileage - 20000, now, 20),
      _item('plugs', 'Spark Plugs', 'Supports reliable ignition and performance.',
          Icons.electric_bolt, 40000, 36, mileage - 15000, now, 18),
      _item('wipers', 'Wiper Blades', 'Maintains visibility in rain and dust.',
          Icons.water_drop, 15000, 12, mileage - 2000, now, 6),
    ];
  }

  MaintenanceItem _item(
    String id,
    String title,
    String description,
    IconData icon,
    int intervalKm,
    int intervalMonths,
    int lastKm,
    DateTime now,
    int monthsAgo,
  ) {
    return MaintenanceItem(
      id: id,
      title: title,
      description: description,
      iconCodePoint: icon.codePoint,
      intervalKm: intervalKm,
      intervalMonths: intervalMonths,
      lastServiceMileage: lastKm < 0 ? 0 : lastKm,
      lastServiceDate: DateTime(now.year, now.month - monthsAgo, now.day),
    );
  }
}

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    super.key,
    required AppState state,
    required super.child,
  }) : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found');
    return scope!.notifier!;
  }
}
