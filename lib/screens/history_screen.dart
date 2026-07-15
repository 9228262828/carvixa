import 'package:flutter/material.dart';
import '../providers/app_state.dart';
import '../widgets/common_widgets.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: state.historyEntries.isEmpty
          ? const Center(child: Padding(padding: EdgeInsets.all(28), child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.history, size: 54), SizedBox(height: 14), Text('No history yet', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)), SizedBox(height: 6), Text('Maintenance and fuel records will appear here.', textAlign: TextAlign.center)])))
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
              itemCount: state.historyEntries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final entry = state.historyEntries[index];
                return Dismissible(
                  key: ValueKey(entry.id),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (_) => showDialog<bool>(context: context, builder: (context) => AlertDialog(title: const Text('Delete record?'), content: const Text('This action cannot be undone.'), actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete'))])),
                  onDismissed: (_) => state.deleteHistory(entry.id),
                  background: Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 22), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(22)), child: const Icon(Icons.delete, color: Colors.white)),
                  child: Card(child: ListTile(
                    leading: CircleAvatar(child: Icon(entry.type == 'fuel' ? Icons.local_gas_station : Icons.build)),
                    title: Text(entry.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: Text('${entry.details}\n${formatDate(entry.date)} • ${entry.mileage} km'),
                    isThreeLine: true,
                    trailing: entry.cost == null ? null : Text('\$${entry.cost!.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w800)),
                  )),
                );
              },
            ),
    );
  }
}
