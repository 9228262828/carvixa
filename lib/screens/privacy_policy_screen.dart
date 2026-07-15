import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  @override
  Widget build(BuildContext context) => const _LegalScreen(title: 'Privacy Policy', sections: [
    ('Overview', 'Carvixa is an offline educational and tracking application designed to help users organize vehicle maintenance and fuel records.'),
    ('Information Stored on Your Device', 'Vehicle details, mileage, maintenance records, fuel entries, history, and theme preferences are stored locally on your device using SharedPreferences.'),
    ('Personal Data', 'Carvixa does not require an account and does not collect your name, email address, phone number, location, contacts, photos, payment information, or advertising identifiers.'),
    ('Permissions', 'The app does not require sensitive permissions and does not access your camera, microphone, contacts, precise location, messages, call information, or personal files.'),
    ('Internet and Third Parties', 'Carvixa does not use a backend server, advertising network, analytics service, or third-party tracking technology for its core functionality.'),
    ('Data Control', 'You control the records saved in the app. Deleting the app or clearing its storage may permanently remove locally stored information.'),
    ('Children’s Privacy', 'Carvixa does not knowingly collect personal information from children or users of any age.'),
    ('Changes', 'This policy may be updated if the app features or legal requirements change.'),
    ('Contact Us', 'For privacy questions, contact brighterhomespacellc@gmail.com.'),
    ('Last Updated', 'July 16, 2026'),
  ]);
}

class _LegalScreen extends StatelessWidget {
  const _LegalScreen({required this.title, required this.sections});
  final String title;
  final List<(String, String)> sections;
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(title)), body: ListView.separated(padding: const EdgeInsets.fromLTRB(20, 10, 20, 30), itemCount: sections.length, separatorBuilder: (_, __) => const SizedBox(height: 18), itemBuilder: (context, index) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(sections[index].$1, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)), const SizedBox(height: 7), Text(sections[index].$2)])));
}
