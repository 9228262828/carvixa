import 'package:flutter/material.dart';
import 'providers/app_state.dart';
import 'screens/splash_screen.dart';
import 'utils/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppState.instance.load();
  runApp(const CarvixaApp());
}

class CarvixaApp extends StatelessWidget {
  const CarvixaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      state: AppState.instance,
      child: AnimatedBuilder(
        animation: AppState.instance,
        builder: (context, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Carvixa',
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: AppState.instance.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
