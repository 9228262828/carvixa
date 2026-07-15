import 'dart:async';
import 'package:flutter/material.dart';
import 'main_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainNavigationScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0D47A1), Color(0xFF1479FF)]),
        ),
        child: const Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            CircleAvatar(radius: 46, backgroundColor: Colors.white, child: Icon(Icons.directions_car_filled_rounded, size: 54, color: Color(0xFF1479FF))),
            SizedBox(height: 22),
            Text('Carvixa', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900)),
            SizedBox(height: 8),
            Text('Your car care companion', style: TextStyle(color: Colors.white70, fontSize: 16)),
          ]),
        ),
      ),
    );
  }
}
