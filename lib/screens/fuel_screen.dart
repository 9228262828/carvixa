import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../providers/app_state.dart';
import '../widgets/common_widgets.dart';

class FuelScreen extends StatelessWidget {
  const FuelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Fuel'), actions: [IconButton(onPressed: () => _addFuel(context, state), icon: const Icon(Icons.add))]),
      floatingActionButton: FloatingActionButton.extended(onPressed: () => _addFuel(context, state), icon: const Icon(Icons.local_gas_station), label: const Text('Add Fuel')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        children: [
          Row(children: [
            Expanded(child: _stat(context, 'Total spent', '\$${state.totalFuelCost.toStringAsFixed(2)}')),
            const SizedBox(width: 12),
            Expanded(child: _stat(context, 'Consumption', state.averageConsumption == null ? 'Not enough data' : '${state.averageConsumption!.toStringAsFixed(1)} L/100km')),
          ]),
          const SizedBox(height: 22),
          const SectionTitle('Fuel Log'),
          const SizedBox(height: 12),
          if (state.fuelEntries.isEmpty)
            const Card(child: Padding(padding: EdgeInsets.all(28), child: Column(children: [Icon(Icons.local_gas_station_outlined, size: 42), SizedBox(height: 12), Text('No fuel entries yet'), SizedBox(height: 5), Text('Add your first fill-up to start tracking costs.')]))),
          ...state.fuelEntries.map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Dismissible(
              key: ValueKey(entry.id),
              direction: DismissDirection.endToStart,
              background: Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 22), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(22)), child: const Icon(Icons.delete, color: Colors.white)),
              onDismissed: (_) => state.deleteFuel(entry.id),
              child: Card(child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.local_gas_station)),
                title: Text('${entry.liters.toStringAsFixed(1)} L • \$${entry.totalCost.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text('${formatDate(entry.date)} • ${entry.mileage} km${entry.fullTank ? ' • Full tank' : ''}'),
              )),
            ),
          )),
        ],
      ),
    );
  }

  Widget _stat(BuildContext context, String label, String value) => Card(child: Padding(
    padding: const EdgeInsets.all(18),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: Theme.of(context).textTheme.bodySmall), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900))]),
  ));

  Future<void> _addFuel(BuildContext context, AppState state) async {
    final liters = TextEditingController();
    final cost = TextEditingController();
    final mileage = TextEditingController(text: state.car.currentMileage.toString());
    bool fullTank = true;
    DateTime date = DateTime.now();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(builder: (context, setModalState) => Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.of(context).viewInsets.bottom + 24),
        child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Add Fuel Entry', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 18),
          TextField(controller: liters, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Liters')),
          const SizedBox(height: 12),
          TextField(controller: cost, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Total cost')),
          const SizedBox(height: 12),
          TextField(controller: mileage, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Mileage (km)')),
          const SizedBox(height: 8),
          SwitchListTile(contentPadding: EdgeInsets.zero, title: const Text('Full tank'), value: fullTank, onChanged: (v) => setModalState(() => fullTank = v)),
          ListTile(contentPadding: EdgeInsets.zero, title: const Text('Date'), subtitle: Text(formatDate(date)), trailing: const Icon(Icons.calendar_month), onTap: () async {
            final picked = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime.now(), initialDate: date);
            if (picked != null) setModalState(() => date = picked);
          }),
          const SizedBox(height: 14),
          SizedBox(width: double.infinity, child: FilledButton(onPressed: () async {
            final l = double.tryParse(liters.text); final c = double.tryParse(cost.text); final km = int.tryParse(mileage.text);
            if (l == null || l <= 0 || c == null || c < 0 || km == null || km < 0) return;
            await state.addFuel(FuelEntry(id: DateTime.now().microsecondsSinceEpoch.toString(), date: date, mileage: km, liters: l, totalCost: c, fullTank: fullTank));
            if (context.mounted) Navigator.pop(context);
          }, child: const Text('Save Fuel Entry'))),
        ])),
      )),
    );
  }
}
