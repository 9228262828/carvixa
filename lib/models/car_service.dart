import 'package:flutter/material.dart';

class CarService {
  const CarService({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.importance,
    required this.signs,
    required this.interval,
    required this.tips,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String description;
  final String importance;
  final List<String> signs;
  final String interval;
  final List<String> tips;
  final IconData icon;
}
