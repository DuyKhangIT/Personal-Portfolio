import 'package:flutter/material.dart';

import '../../local_database/database_constant.dart';
import '../../local_database/storage_manager.dart';

part '../implement/theme_mode_service.dart';

abstract class IThemeModeService {
  Future<void> setThemeMode(ThemeMode themeMode);
  ThemeMode getThemeMode();
}
