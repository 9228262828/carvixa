import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../providers/app_state.dart';
import '../widgets/common_widgets.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Maintenance')),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        itemCount: state.maintenanceItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: 11),
        itemBuilder: (context, index) {
          final item = state.maintenanceItems[index];
          final status = item.status(state.car.currentMileage);
          return Card(child: InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () => _openDetails(context, state, item),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                CircleAvatar(radius: 25, child: Icon(IconData(item.iconCodePoint, fontFamily: 'MaterialIcons'))),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [Expanded(child: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16))), StatusChip(status)]),
                  const SizedBox(height: 6),
                  Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Text('${item.nextMileage - state.car.currentMileage} km • ${formatDate(item.nextDate)}', style: Theme.of(context).textTheme.bodySmall),
                ])),
              ]),
            ),
          ));
        },
      ),
    );
  }

  Future<void> _openDetails(BuildContext context, AppState state, MaintenanceItem item) async {
    final mileage = TextEditingController(text: state.car.currentMileage.toString());
    final cost = TextEditingController();
    final note = TextEditingController();
    DateTime date = DateTime.now();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(builder: (context, setModalState) => Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.of(context).viewInsets.bottom + 24),
        child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Text(item.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 8), Text(item.description), const SizedBox(height: 18),
          Text('Last service: ${item.lastServiceMileage} km • ${formatDate(item.lastServiceDate)}'),
          Text('Interval: ${item.intervalKm} km or ${item.intervalMonths} months'),
          const SizedBox(height: 18),
          TextField(controller: mileage, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Service mileage')),
          const SizedBox(height: 12),
          TextField(controller: cost, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Cost (optional)')),
          const SizedBox(height: 12),
          TextField(controller: note, decoration: const InputDecoration(labelText: 'Note (optional)')),
          const SizedBox(height: 12),
          ListTile(contentPadding: EdgeInsets.zero, title: const Text('Service date'), subtitle: Text(formatDate(date)), trailing: const Icon(Icons.calendar_month), onTap: () async {
            final picked = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime.now(), initialDate: date);
            if (picked != null) setModalState(() => date = picked);
          }),
          const SizedBox(height: 14),
          SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: () async {
            final km = int.tryParse(mileage.text);
            if (km == null || km < 0) return;
            await state.serviceItem(item: item, mileage: km, date: date, cost: double.tryParse(cost.text), note: note.text.trim());
            if (context.mounted) Navigator.pop(context);
          }, icon: const Icon(Icons.check), label: const Text('Mark as Serviced'))),
        ])),
      )),
    );
  }
}
