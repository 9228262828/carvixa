import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../providers/app_state.dart';
import '../widgets/common_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final upcoming = [...state.maintenanceItems]
      ..sort((a, b) => a.nextMileage.compareTo(b.nextMileage));

    return Scaffold(
      appBar: AppBar(title: const Text('Carvixa'), actions: [IconButton(onPressed: () => _updateMileage(context, state), icon: const Icon(Icons.speed))]),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF0D47A1), Color(0xFF1479FF)]),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const CircleAvatar(radius: 28, backgroundColor: Colors.white24, child: Icon(Icons.directions_car_filled, color: Colors.white, size: 32)),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(state.car.name, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                  Text('${state.car.make} ${state.car.model} • ${state.car.year}', style: const TextStyle(color: Colors.white70)),
                ])),
              ]),
              const SizedBox(height: 24),
              Row(children: [
                Expanded(child: _heroValue('Mileage', '${state.car.currentMileage} km')),
                Expanded(child: _heroValue('Car Health', '${state.healthScore}%')),
              ]),
              const SizedBox(height: 16),
              SizedBox(width: double.infinity, child: FilledButton.tonal(onPressed: () => _updateMileage(context, state), child: const Text('Update Mileage'))),
            ]),
          ),
          const SizedBox(height: 22),
          Row(children: [
            Expanded(child: _summaryCard(context, 'Good', state.goodCount, Icons.check_circle, Colors.green)),
            const SizedBox(width: 10),
            Expanded(child: _summaryCard(context, 'Due Soon', state.dueSoonCount, Icons.schedule, Colors.orange)),
            const SizedBox(width: 10),
            Expanded(child: _summaryCard(context, 'Overdue', state.overdueCount, Icons.warning_rounded, Colors.red)),
          ]),
          const SizedBox(height: 24),
          const SectionTitle('Upcoming Maintenance'),
          const SizedBox(height: 12),
          ...upcoming.take(4).map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(child: ListTile(
              leading: CircleAvatar(child: Icon(IconData(item.iconCodePoint, fontFamily: 'MaterialIcons'))),
              title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text(_remainingText(item, state.car.currentMileage)),
              trailing: StatusChip(item.status(state.car.currentMileage)),
            )),
          )),
          const SizedBox(height: 12),
          const SectionTitle('Fuel Overview'),
          const SizedBox(height: 12),
          Card(child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(children: [
              Expanded(child: _metric(context, 'Total spent', '\$${state.totalFuelCost.toStringAsFixed(2)}')),
              Container(width: 1, height: 46, color: Theme.of(context).dividerColor),
              Expanded(child: _metric(context, 'Avg. use', state.averageConsumption == null ? 'Add 2 full tanks' : '${state.averageConsumption!.toStringAsFixed(1)} L/100km')),
            ]),
          )),
        ],
      ),
    );
  }

  Widget _heroValue(String label, String value) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: const TextStyle(color: Colors.white70)),
    const SizedBox(height: 4),
    Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 19)),
  ]);

  Widget _summaryCard(BuildContext context, String label, int value, IconData icon, Color color) => Card(child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    child: Column(children: [Icon(icon, color: color), const SizedBox(height: 7), Text('$value', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)), Text(label, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall)]),
  ));

  Widget _metric(BuildContext context, String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(children: [Text(value, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17)), const SizedBox(height: 4), Text(label, style: Theme.of(context).textTheme.bodySmall)]),
  );

  String _remainingText(MaintenanceItem item, int currentMileage) {
    final km = item.nextMileage - currentMileage;
    if (km < 0) return '${km.abs()} km overdue';
    return '$km km remaining';
  }

  Future<void> _updateMileage(BuildContext context, AppState state) async {
    final controller = TextEditingController(text: state.car.currentMileage.toString());
    final result = await showDialog<int>(context: context, builder: (context) => AlertDialog(
      title: const Text('Update Mileage'),
      content: TextField(controller: controller, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Current mileage (km)')),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(context, int.tryParse(controller.text)), child: const Text('Save'))],
    ));
    if (result != null && result >= 0) await state.updateCar(state.car.copyWith(currentMileage: result));
  }
}
