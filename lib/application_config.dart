import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'Global/app_bloc_observer.dart';
import 'core/local_database/storage_manager.dart';
import 'global/locator_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  registerServiceSingletons(locator);
}

Future<void> initializeAppConfig() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await StorageManager.init();
  UrlLauncherPlugin.registerWith(webPluginRegistrar);
  Bloc.observer = AppBlocObserver();
  setupLocator();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
