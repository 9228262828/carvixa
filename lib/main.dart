import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/theme_provider.dart';
import 'screens/splash_screen.dart';
import 'utils/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  runApp(CarvixaApp(preferences: preferences));
}

class CarvixaApp extends StatefulWidget {
  const CarvixaApp({super.key, required this.preferences});

  final SharedPreferences preferences;

  @override
  State<CarvixaApp> createState() => _CarvixaAppState();
}

class _CarvixaAppState extends State<CarvixaApp> {
  late final ThemeProvider _themeProvider;

  @override
  void initState() {
    super.initState();
    _themeProvider = ThemeProvider(widget.preferences);
  }

  @override
  void dispose() {
    _themeProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeController(
      notifier: _themeProvider,
      child: AnimatedBuilder(
        animation: _themeProvider,
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Carvixa',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: _themeProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
