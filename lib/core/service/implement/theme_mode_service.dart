part of '../interfaces/itheme_mode_service.dart';

class ThemeModeService implements IThemeModeService {
  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await StorageManager.saveData(DatabaseConstant.themeMode, themeMode.index);
  }

  @override
  ThemeMode getThemeMode() {
    try {
      final themeValue = StorageManager.readData(DatabaseConstant.themeMode);
      if (themeValue == null) return ThemeMode.system;
      return ThemeMode.values[themeValue as int];
    } catch (e) {
      debugPrint(e.toString());
      return ThemeMode.system;
    }
  }
}
