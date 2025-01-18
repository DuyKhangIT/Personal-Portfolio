import 'package:get_it/get_it.dart';
import 'package:personal_portfolio/core/service/interfaces/itheme_mode_service.dart';

void registerServiceSingletons(GetIt locator) {
  locator.registerLazySingleton<IThemeModeService>(() => ThemeModeService());
}
