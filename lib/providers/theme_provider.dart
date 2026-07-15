import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(this._preferences)
      : _isDarkMode = _preferences.getBool(_darkModeKey) ?? false;

  static const String _darkModeKey = 'dark_mode';

  final SharedPreferences _preferences;
  bool _isDarkMode;

  bool get isDarkMode => _isDarkMode;

  Future<void> setDarkMode(bool value) async {
    if (_isDarkMode == value) return;
    _isDarkMode = value;
    notifyListeners();
    await _preferences.setBool(_darkModeKey, value);
  }
}

class ThemeController extends InheritedNotifier<ThemeProvider> {
  const ThemeController({
    super.key,
    required ThemeProvider notifier,
    required super.child,
  }) : super(notifier: notifier);

  static ThemeProvider of(BuildContext context) {
    final controller =
        context.dependOnInheritedWidgetOfExactType<ThemeController>();
    assert(controller != null, 'ThemeController was not found in the tree.');
    return controller!.notifier!;
  }
}
