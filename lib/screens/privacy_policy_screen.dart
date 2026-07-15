import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LegalScreen(
      title: 'Privacy Policy',
      sections: [

          _LegalSection(
            heading: 'Overview',
            body:
            'Carvixa is an offline educational application designed to provide general car maintenance information, service recommendations, and practical vehicle care guidance. The application works entirely on your device without requiring user registration or an online account. We respect your privacy and are committed to protecting your information.',
          ),

          _LegalSection(
            heading: 'Information We Collect',
            body:
            'Carvixa does not collect, request, process, or store any personally identifiable information. We do not ask for your name, email address, phone number, home address, date of birth, payment information, or any other personal details.',
          ),

          _LegalSection(
            heading: 'Device Permissions',
            body:
            'Carvixa is designed to operate without requesting sensitive Android permissions. The application does not access your camera, microphone, contacts, SMS messages, call history, calendar, Bluetooth, precise location, background location, storage files, or installed applications.',
          ),

          _LegalSection(
            heading: 'Offline Functionality',
            body:
            'All educational content included in Carvixa is stored within the application package. No internet connection is required to access the main features, read maintenance guides, or browse service information.',
          ),

          _LegalSection(
            heading: 'Local Storage',
            body:
            'The application may locally save simple user preferences such as the selected theme (Light or Dark Mode) using SharedPreferences. These preferences remain exclusively on your device and are never transmitted outside your phone.',
          ),

          _LegalSection(
            heading: 'No User Accounts',
            body:
            'Carvixa does not require account creation, user login, password authentication, social media sign-in, or identity verification. You can use every feature immediately after installing the application.',
          ),

          _LegalSection(
            heading: 'No Data Sharing',
            body:
            'We do not sell, rent, exchange, transfer, or share user information with advertisers, analytics providers, marketing companies, government agencies, or any third-party organizations because no personal information is collected.',
          ),

          _LegalSection(
            heading: 'Analytics and Advertising',
            body:
            'Carvixa does not include advertising SDKs, behavioral analytics, crash analytics, marketing trackers, or user profiling technologies. Your activity inside the application is not monitored or analyzed.',
          ),

          _LegalSection(
            heading: 'Third-Party Services',
            body:
            'The application does not rely on cloud servers, external APIs, social media platforms, advertising networks, or third-party services for its primary functionality.',
          ),

          _LegalSection(
            heading: 'Security',
            body:
            'Since Carvixa does not collect or transmit personal information, there is no personal user database maintained by the application. Your locally stored preferences remain under the security protections provided by your Android device.',
          ),

          _LegalSection(
            heading: 'Children\'s Privacy',
            body:
            'Carvixa is suitable for general audiences and does not knowingly collect personal information from children under the age of 13 or from users of any age.',
          ),

          _LegalSection(
            heading: 'Medical or Mechanical Disclaimer',
            body:
            'The maintenance information provided by Carvixa is intended for educational and informational purposes only. Vehicle maintenance schedules may vary depending on the manufacturer, vehicle model, driving conditions, and service history. Always consult your vehicle owner\'s manual or a qualified automotive technician before making maintenance decisions.',
          ),

          _LegalSection(
            heading: 'Policy Changes',
            body:
            'This Privacy Policy may be updated from time to time if new features are introduced or legal requirements change. The latest version will always be available within the application.',
          ),

          _LegalSection(
            heading: 'Contact Us',
            body:
            'If you have any questions, suggestions, or concerns regarding this Privacy Policy or the Carvixa application, you may contact us at:\n\nbrighterhomespacellc@gmail.com',
          ),

          _LegalSection(
            heading: 'Last Updated',
            body: 'july, 2026',
          ),
        ],
    );
  }
}

class _LegalScreen extends StatelessWidget {
  const _LegalScreen({required this.title, required this.sections});

  final String title;
  final List<_LegalSection> sections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 18),
        itemBuilder: (context, index) {
          final section = sections[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section.heading,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 7),
              Text(section.body),
            ],
          );
        },
      ),
    );
  }
}

class _LegalSection {
  const _LegalSection({required this.heading, required this.body});

  final String heading;
  final String body;
}
