import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const sections = [
    (
    'Acceptance of Terms',
    'By downloading, installing, or using Carvixa, you agree to comply with these Terms and Conditions. If you do not agree with any part of these terms, please discontinue using the application.'
    ),

    (
    'Purpose of the Application',
    'Carvixa is an educational application created to provide general information about vehicle maintenance, preventive care, and common automotive services. The application is intended solely for informational purposes.'
    ),

    (
    'Not Professional Advice',
    'The information provided by Carvixa should not be considered professional mechanical advice, vehicle diagnostics, repair instructions, or technical certification. Always consult a qualified automotive technician before performing repairs or making important maintenance decisions.'
    ),

    (
    'Vehicle Differences',
    'Every vehicle is different. Maintenance schedules and service recommendations vary depending on the manufacturer, vehicle model, production year, engine type, mileage, driving style, weather conditions, and regional requirements. Always refer to your official vehicle owners manual.'
    ),

    (
    'User Responsibility',
    'You are solely responsible for any maintenance or repair decisions you make based on the information available in the application. Carvixa cannot determine the condition of your vehicle and should never replace professional inspections.'
    ),

    (
    'Safety Warning',
    'Never attempt repairs or maintenance procedures that exceed your knowledge, experience, or available equipment. Improper repairs may lead to vehicle damage, personal injury, or unsafe driving conditions.'
    ),

    (
    'Accuracy of Information',
    'We strive to provide accurate, understandable, and useful automotive information. However, we do not guarantee that all content will always be complete, current, error-free, or applicable to every vehicle or situation.'
    ),

    (
    'Offline Application',
    'Carvixa operates primarily as an offline application. Some future versions may introduce optional online features, but the current version is designed to function without requiring user accounts or internet connectivity.'
    ),

    (
    'Intellectual Property',
    'All application content, including text, graphics, icons, layouts, branding, and software components, is protected by applicable intellectual property laws. You may not copy, redistribute, modify, or reproduce any part of the application without prior written permission.'
    ),

    (
    'Prohibited Use',
    'You agree not to misuse the application, attempt unauthorized modifications, reverse engineer the software, distribute altered versions, or use the application for unlawful purposes.'
    ),

    (
    'Limitation of Liability',
    'To the maximum extent permitted by applicable law, the developer of Carvixa shall not be liable for any direct, indirect, incidental, consequential, special, or punitive damages arising from the use of or inability to use the application or reliance upon its content.'
    ),

    (
    'No Warranty',
    'The application is provided "AS IS" and "AS AVAILABLE" without warranties of any kind, whether express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, or non-infringement.'
    ),

    (
    'Updates',
    'The developer may improve, modify, replace, suspend, or discontinue any feature of the application at any time without prior notice.'
    ),

    (
    'Changes to These Terms',
    'These Terms and Conditions may be updated periodically to reflect improvements, legal requirements, or new application features. Continued use of the application after updates constitutes acceptance of the revised Terms.'
    ),

    (
    'Contact Information',
    'If you have any questions regarding these Terms and Conditions, you may contact us at:\n\nbrighterhomespacellc@gmail.com'
    ),

    (
    'Governing Law',
    'These Terms and Conditions shall be governed by and interpreted in accordance with the applicable laws and regulations governing the distribution and use of software applications.'
    ),

    (
    'Last Updated',
    'july, 2026'
    ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
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
                section.$1,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 7),
              Text(section.$2),
            ],
          );
        },
      ),
    );
  }
}
