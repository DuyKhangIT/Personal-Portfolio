import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
  Bloc.observer = AppBlocObserver();
  setupLocator();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
