import 'package:flutter/material.dart';

import '../models/car_service.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({super.key, required this.service});

  final CarService service;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(service.title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              children: [
                Icon(
                  service.icon,
                  size: 62,
                  color: colors.onPrimaryContainer,
                ),
                const SizedBox(height: 14),
                Text(
                  service.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: colors.onPrimaryContainer,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  service.subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colors.onPrimaryContainer.withValues(alpha: 0.8),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _InfoSection(
            title: 'About this service',
            icon: Icons.info_outline_rounded,
            child: Text(service.description),
          ),
          _InfoSection(
            title: 'Why it matters',
            icon: Icons.shield_outlined,
            child: Text(service.importance),
          ),
          _InfoSection(
            title: 'Common warning signs',
            icon: Icons.warning_amber_rounded,
            child: _BulletList(items: service.signs),
          ),
          _InfoSection(
            title: 'Recommended interval',
            icon: Icons.schedule_rounded,
            child: Text(service.interval),
          ),
          _InfoSection(
            title: 'Helpful tips',
            icon: Icons.lightbulb_outline_rounded,
            child: _BulletList(items: service.tips),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.secondaryContainer,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.engineering_rounded,
                    color: colors.onSecondaryContainer),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'This guide is educational only. Follow your vehicle manual and consult a qualified technician when needed.',
                    style: TextStyle(color: colors.onSecondaryContainer),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: colors.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DefaultTextStyle.merge(
                style: Theme.of(context).textTheme.bodyLarge,
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
