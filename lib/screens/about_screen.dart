import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('About Carvixa')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.directions_car_filled_rounded,
                size: 56,
                color: colors.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Carvixa',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Simple car care guidance',
            textAlign: TextAlign.center,
            style: TextStyle(color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: 28),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Carvixa is a lightweight offline guide that explains common vehicle maintenance services, warning signs, recommended checks, and practical safety tips.\n\nThe app does not diagnose vehicle problems and does not replace professional inspection or your vehicle owner manual.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
