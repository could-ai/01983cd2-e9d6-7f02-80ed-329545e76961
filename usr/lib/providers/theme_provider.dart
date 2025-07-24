import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:couldai_user_app/services/local_storage_service.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final localStorageService = ref.read(localStorageServiceProvider);
  return ThemeNotifier(localStorageService);
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final LocalStorageService _localStorageService;

  ThemeNotifier(this._localStorageService) : super(ThemeMode.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final storedTheme = await _localStorageService.getThemeMode();
    state = storedTheme ?? ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode newMode) async {
    state = newMode;
    await _localStorageService.saveThemeMode(newMode);
  }
}
