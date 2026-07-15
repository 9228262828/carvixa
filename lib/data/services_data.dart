import 'package:flutter/material.dart';

import '../models/car_service.dart';

const List<CarService> carServices = [
  CarService(
    title: 'Engine Oil',
    subtitle: 'Protect your engine and keep it running smoothly.',
    description:
        'Engine oil reduces friction between moving parts and helps control heat inside the engine.',
    importance:
        'Old or low oil may increase engine wear, reduce performance, and cause expensive damage.',
    signs: [
      'Oil warning light appears',
      'Engine sounds louder than usual',
      'Oil looks very dark or dirty',
      'Burning oil smell',
    ],
    interval:
        'Check the oil level monthly. Replace it according to the vehicle manufacturer schedule, commonly every 5,000 to 10,000 km.',
    tips: [
      'Park on a level surface before checking the oil.',
      'Use the oil grade recommended in the owner manual.',
      'Do not overfill the engine.',
    ],
    icon: Icons.oil_barrel_rounded,
  ),
  CarService(
    title: 'Tires',
    subtitle: 'Improve grip, comfort, and fuel efficiency.',
    description:
        'Correct tire pressure and healthy tread improve steering, braking, and road safety.',
    importance:
        'Underinflated, overinflated, or worn tires can reduce grip and increase stopping distance.',
    signs: [
      'Uneven tread wear',
      'Vehicle pulls to one side',
      'Frequent pressure loss',
      'Cracks or visible damage',
    ],
    interval:
        'Check tire pressure at least once a month and before long trips. Rotate tires as recommended by the manufacturer.',
    tips: [
      'Check pressure when tires are cold.',
      'Use the pressure listed on the driver door label.',
      'Inspect the spare tire too.',
    ],
    icon: Icons.tire_repair_rounded,
  ),
  CarService(
    title: 'Car Battery',
    subtitle: 'Support reliable starting and electrical systems.',
    description:
        'The battery supplies power to start the engine and supports the vehicle electrical components.',
    importance:
        'A weak battery may leave the vehicle unable to start and can affect electrical systems.',
    signs: [
      'Slow engine cranking',
      'Dim headlights',
      'Battery warning light',
      'Corrosion around terminals',
    ],
    interval:
        'Inspect the battery every few months. Many batteries last around three to five years depending on climate and usage.',
    tips: [
      'Keep battery terminals clean and secure.',
      'Avoid leaving lights on when the engine is off.',
      'Have the charging system checked if problems repeat.',
    ],
    icon: Icons.battery_charging_full_rounded,
  ),
  CarService(
    title: 'Brakes',
    subtitle: 'Maintain confident and safe stopping.',
    description:
        'The braking system uses pads, discs, fluid, and other components to slow and stop the vehicle.',
    importance:
        'Brake wear can reduce stopping performance and put the driver and passengers at risk.',
    signs: [
      'Squeaking or grinding noise',
      'Soft or vibrating brake pedal',
      'Longer stopping distance',
      'Brake warning light',
    ],
    interval:
        'Have the brakes inspected during regular maintenance or whenever you notice unusual noise, vibration, or reduced performance.',
    tips: [
      'Do not ignore grinding sounds.',
      'Check brake fluid based on the owner manual.',
      'Use a qualified technician for brake repairs.',
    ],
    icon: Icons.car_crash_rounded,
  ),
  CarService(
    title: 'Air Filter',
    subtitle: 'Help the engine breathe clean air.',
    description:
        'The engine air filter captures dust and debris before air enters the engine.',
    importance:
        'A clogged filter may reduce airflow, performance, and fuel efficiency.',
    signs: [
      'Reduced acceleration',
      'Higher fuel consumption',
      'Dirty or dark filter surface',
      'Unusual engine sound',
    ],
    interval:
        'Inspect it during scheduled maintenance and replace it more often in dusty driving conditions.',
    tips: [
      'Follow the replacement interval in the owner manual.',
      'Make sure the filter housing closes properly.',
      'Use a filter designed for your vehicle model.',
    ],
    icon: Icons.air_rounded,
  ),
  CarService(
    title: 'Coolant',
    subtitle: 'Control engine temperature and prevent overheating.',
    description:
        'Coolant circulates through the engine and radiator to manage heat and protect the cooling system.',
    importance:
        'Low or degraded coolant can cause overheating, corrosion, and engine damage.',
    signs: [
      'Temperature gauge rises',
      'Coolant warning light',
      'Sweet smell near the vehicle',
      'Visible leak under the car',
    ],
    interval:
        'Check the coolant reservoir regularly when the engine is cold. Replace coolant according to the manufacturer schedule.',
    tips: [
      'Never open a hot radiator cap.',
      'Use the correct coolant type and mixture.',
      'Investigate repeated coolant loss quickly.',
    ],
    icon: Icons.thermostat_rounded,
  ),
  CarService(
    title: 'Wipers',
    subtitle: 'Maintain clear visibility in rain and dust.',
    description:
        'Wiper blades remove water and dirt from the windshield to improve visibility.',
    importance:
        'Damaged blades can leave streaks, scratch glass, and reduce visibility in bad weather.',
    signs: [
      'Streaks on the windshield',
      'Skipping or chattering movement',
      'Cracked rubber edges',
      'Poor cleaning performance',
    ],
    interval:
        'Inspect blades every few months and replace them when cleaning performance decreases.',
    tips: [
      'Clean the rubber edges gently.',
      'Keep washer fluid filled.',
      'Do not run wipers on a dry, dusty windshield.',
    ],
    icon: Icons.water_drop_rounded,
  ),
  CarService(
    title: 'Air Conditioning',
    subtitle: 'Keep the cabin comfortable and fresh.',
    description:
        'The air conditioning system cools and dehumidifies cabin air while the cabin filter reduces dust and particles.',
    importance:
        'Regular care helps maintain cooling performance and improves cabin comfort.',
    signs: [
      'Weak airflow',
      'Air is not cold enough',
      'Unpleasant smell',
      'Unusual noise when AC starts',
    ],
    interval:
        'Inspect the system when performance drops. Replace the cabin filter according to the vehicle schedule or dusty conditions.',
    tips: [
      'Run the AC periodically, even in cooler months.',
      'Replace a dirty cabin filter.',
      'Use a qualified technician for refrigerant service.',
    ],
    icon: Icons.ac_unit_rounded,
  ),
];
