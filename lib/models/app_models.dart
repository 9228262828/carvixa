import 'dart:convert';

enum MaintenanceStatus { good, dueSoon, overdue }

class CarProfile {
  const CarProfile({
    required this.name,
    required this.make,
    required this.model,
    required this.year,
    required this.currentMileage,
  });

  final String name;
  final String make;
  final String model;
  final int year;
  final int currentMileage;

  CarProfile copyWith({
    String? name,
    String? make,
    String? model,
    int? year,
    int? currentMileage,
  }) {
    return CarProfile(
      name: name ?? this.name,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      currentMileage: currentMileage ?? this.currentMileage,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'make': make,
        'model': model,
        'year': year,
        'currentMileage': currentMileage,
      };

  factory CarProfile.fromMap(Map<String, dynamic> map) => CarProfile(
        name: map['name'] as String? ?? 'My Car',
        make: map['make'] as String? ?? '',
        model: map['model'] as String? ?? '',
        year: (map['year'] as num?)?.toInt() ?? DateTime.now().year,
        currentMileage: (map['currentMileage'] as num?)?.toInt() ?? 0,
      );
}

class MaintenanceItem {
  const MaintenanceItem({
    required this.id,
    required this.title,
    required this.description,
    required this.iconCodePoint,
    required this.intervalKm,
    required this.intervalMonths,
    required this.lastServiceMileage,
    required this.lastServiceDate,
  });

  final String id;
  final String title;
  final String description;
  final int iconCodePoint;
  final int intervalKm;
  final int intervalMonths;
  final int lastServiceMileage;
  final DateTime lastServiceDate;

  int get nextMileage => lastServiceMileage + intervalKm;

  DateTime get nextDate => DateTime(
        lastServiceDate.year,
        lastServiceDate.month + intervalMonths,
        lastServiceDate.day,
      );

  MaintenanceStatus status(int currentMileage) {
    final kmRemaining = nextMileage - currentMileage;
    final daysRemaining = nextDate.difference(DateTime.now()).inDays;
    if (kmRemaining < 0 || daysRemaining < 0) return MaintenanceStatus.overdue;
    if (kmRemaining <= 500 || daysRemaining <= 30) {
      return MaintenanceStatus.dueSoon;
    }
    return MaintenanceStatus.good;
  }

  MaintenanceItem copyWith({
    int? intervalKm,
    int? intervalMonths,
    int? lastServiceMileage,
    DateTime? lastServiceDate,
  }) {
    return MaintenanceItem(
      id: id,
      title: title,
      description: description,
      iconCodePoint: iconCodePoint,
      intervalKm: intervalKm ?? this.intervalKm,
      intervalMonths: intervalMonths ?? this.intervalMonths,
      lastServiceMileage: lastServiceMileage ?? this.lastServiceMileage,
      lastServiceDate: lastServiceDate ?? this.lastServiceDate,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'iconCodePoint': iconCodePoint,
        'intervalKm': intervalKm,
        'intervalMonths': intervalMonths,
        'lastServiceMileage': lastServiceMileage,
        'lastServiceDate': lastServiceDate.toIso8601String(),
      };

  factory MaintenanceItem.fromMap(Map<String, dynamic> map) => MaintenanceItem(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String? ?? '',
        iconCodePoint: (map['iconCodePoint'] as num?)?.toInt() ?? 0xe1d5,
        intervalKm: (map['intervalKm'] as num?)?.toInt() ?? 5000,
        intervalMonths: (map['intervalMonths'] as num?)?.toInt() ?? 6,
        lastServiceMileage:
            (map['lastServiceMileage'] as num?)?.toInt() ?? 0,
        lastServiceDate: DateTime.tryParse(
              map['lastServiceDate'] as String? ?? '',
            ) ??
            DateTime.now(),
      );
}

class FuelEntry {
  const FuelEntry({
    required this.id,
    required this.date,
    required this.mileage,
    required this.liters,
    required this.totalCost,
    required this.fullTank,
  });

  final String id;
  final DateTime date;
  final int mileage;
  final double liters;
  final double totalCost;
  final bool fullTank;

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date.toIso8601String(),
        'mileage': mileage,
        'liters': liters,
        'totalCost': totalCost,
        'fullTank': fullTank,
      };

  factory FuelEntry.fromMap(Map<String, dynamic> map) => FuelEntry(
        id: map['id'] as String,
        date: DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now(),
        mileage: (map['mileage'] as num?)?.toInt() ?? 0,
        liters: (map['liters'] as num?)?.toDouble() ?? 0,
        totalCost: (map['totalCost'] as num?)?.toDouble() ?? 0,
        fullTank: map['fullTank'] as bool? ?? false,
      );
}

class HistoryEntry {
  const HistoryEntry({
    required this.id,
    required this.title,
    required this.details,
    required this.date,
    required this.mileage,
    required this.type,
    this.cost,
  });

  final String id;
  final String title;
  final String details;
  final DateTime date;
  final int mileage;
  final String type;
  final double? cost;

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'details': details,
        'date': date.toIso8601String(),
        'mileage': mileage,
        'type': type,
        'cost': cost,
      };

  factory HistoryEntry.fromMap(Map<String, dynamic> map) => HistoryEntry(
        id: map['id'] as String,
        title: map['title'] as String? ?? '',
        details: map['details'] as String? ?? '',
        date: DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now(),
        mileage: (map['mileage'] as num?)?.toInt() ?? 0,
        type: map['type'] as String? ?? 'maintenance',
        cost: (map['cost'] as num?)?.toDouble(),
      );
}

String encodeList(List<Map<String, dynamic>> values) => jsonEncode(values);

List<Map<String, dynamic>> decodeList(String? value) {
  if (value == null || value.isEmpty) return [];
  final decoded = jsonDecode(value) as List<dynamic>;
  return decoded.cast<Map<String, dynamic>>();
}
