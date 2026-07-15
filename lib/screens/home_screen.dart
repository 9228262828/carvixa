import 'package:flutter/material.dart';

import '../data/services_data.dart';
import '../widgets/service_card.dart';
import 'service_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carvixa'),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 16),
            child: CircleAvatar(
              backgroundColor: colors.primaryContainer,
              child: Icon(
                Icons.directions_car_filled_rounded,
                color: colors.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colors.primary,
                    colors.primary.withValues(alpha: 0.78),
                  ],
                ),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Simple car care,\nclear guidance.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            height: 1.2,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Explore essential maintenance services and useful warning signs.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.86),
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Icon(
                    Icons.car_repair_rounded,
                    size: 74,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Text(
              'Car Care Services',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 6),
            Text(
              'Select a service to learn more.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 14),
            ...carServices.map(
              (service) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ServiceCard(
                  service: service,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ServiceDetailsScreen(service: service),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
