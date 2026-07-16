import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const sections = [
      ('Acceptance of Terms', 'By downloading or using Carvixa, you agree to these Terms and Conditions.'),
      ('Application Purpose', 'Carvixa helps users organize vehicle maintenance, mileage, fuel, and service history. It is provided for informational and organizational purposes.'),
      ('Not Professional Advice', 'The app does not provide vehicle diagnostics, repair guarantees, inspection reports, or professional mechanical advice.'),
      ('User-Entered Data', 'Calculations and reminders depend on the information you enter. You are responsible for keeping mileage, service intervals, dates, costs, and fuel records accurate.'),
      ('Vehicle Differences', 'Maintenance requirements vary by vehicle, manufacturer, model, year, engine, climate, road conditions, and driving habits. Always follow the official owner manual.'),
      ('Safety', 'Seek help from a qualified technician for warning lights, leaks, overheating, braking issues, unusual sounds, or any condition that may affect safety.'),
      ('No Warranty', 'The app is provided as-is without guarantees that its calculations, reminders, or content are complete or suitable for every vehicle.'),
      ('Limitation of Liability', 'To the maximum extent permitted by law, the developer is not responsible for damage, injury, loss, repair cost, missed maintenance, or other consequences arising from use of the app.'),
      ('Local Data', 'App records are stored locally. Removing the app or clearing its storage may permanently delete your data.'),
      ('Changes', 'Features and these terms may be changed or updated in future versions.'),
      ('Contact Us', 'For questions, contact brighterhomespacellc@gmail.com.'),
      ('Last Updated', 'July, 2026'),
    ];
    return Scaffold(appBar: AppBar(title: const Text('Terms & Conditions')), body: ListView.separated(padding: const EdgeInsets.fromLTRB(20, 10, 20, 30), itemCount: sections.length, separatorBuilder: (_, __) => const SizedBox(height: 18), itemBuilder: (context, index) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(sections[index].$1, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)), const SizedBox(height: 7), Text(sections[index].$2)])));
  }
}
