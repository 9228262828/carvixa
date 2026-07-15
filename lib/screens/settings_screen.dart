import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../providers/app_state.dart';
import 'privacy_policy_screen.dart';
import 'terms_conditions_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(padding: const EdgeInsets.fromLTRB(16, 8, 16, 28), children: [
        Card(child: Column(children: [
          ListTile(leading: const Icon(Icons.directions_car), title: const Text('Vehicle Details'), subtitle: Text('${state.car.make} ${state.car.model} • ${state.car.currentMileage} km'), trailing: const Icon(Icons.chevron_right), onTap: () => _editVehicle(context, state)),
          const Divider(height: 1),
          SwitchListTile(secondary: const Icon(Icons.dark_mode), title: const Text('Dark Mode'), value: state.isDarkMode, onChanged: state.toggleTheme),
        ])),
        const SizedBox(height: 16),
        Card(child: Column(children: [
          ListTile(leading: const Icon(Icons.privacy_tip_outlined), title: const Text('Privacy Policy'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()))),
          const Divider(height: 1),
          ListTile(leading: const Icon(Icons.description_outlined), title: const Text('Terms & Conditions'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsConditionsScreen()))),
          const Divider(height: 1),
          const ListTile(leading: Icon(Icons.info_outline), title: Text('About Carvixa'), subtitle: Text('Offline car maintenance and fuel tracker\nVersion 1.0.0'), isThreeLine: true),
        ])),
      ]),
    );
  }

  Future<void> _editVehicle(BuildContext context, AppState state) async {
    final name = TextEditingController(text: state.car.name);
    final make = TextEditingController(text: state.car.make);
    final model = TextEditingController(text: state.car.model);
    final year = TextEditingController(text: state.car.year.toString());
    final mileage = TextEditingController(text: state.car.currentMileage.toString());
    await showDialog<void>(context: context, builder: (context) => AlertDialog(
      title: const Text('Vehicle Details'),
      content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'Vehicle name')),
        const SizedBox(height: 10), TextField(controller: make, decoration: const InputDecoration(labelText: 'Make')),
        const SizedBox(height: 10), TextField(controller: model, decoration: const InputDecoration(labelText: 'Model')),
        const SizedBox(height: 10), TextField(controller: year, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Year')),
        const SizedBox(height: 10), TextField(controller: mileage, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Current mileage')),
      ])),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')), FilledButton(onPressed: () async {
        final y = int.tryParse(year.text); final km = int.tryParse(mileage.text);
        if (y == null || km == null || name.text.trim().isEmpty) return;
        await state.updateCar(CarProfile(name: name.text.trim(), make: make.text.trim(), model: model.text.trim(), year: y, currentMileage: km));
        if (context.mounted) Navigator.pop(context);
      }, child: const Text('Save'))],
    ));
  }
}
