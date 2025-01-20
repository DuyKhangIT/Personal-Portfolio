import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:personal_portfolio/pages/main_page.dart';

import 'application_config.dart';
import 'Global/locale.dart';
import 'core/blocs/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import 'core/blocs/setting_bloc/setting_bloc.dart';
import 'global/app_themes.dart';

void main() {
  mainDelegate();
}

Future<void> mainDelegate() async {
  await initializeAppConfig();
  runApp(
    EasyLocalization(
      supportedLocales: MyLocale.myLocales.map((e) => e.locale).toList(),
      path: 'assets/translations',
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 900),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<SettingBloc>(
              create: (_) => SettingBloc(),
            ),
            BlocProvider<BottomNavBarCubit>(
              create: (_) => BottomNavBarCubit(),
            ),
          ],
          child: BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              return SafeArea(
                maintainBottomViewPadding: true,
                child: GetMaterialApp(
                  title: 'Duy Khang',
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  theme: lightTheme,
                  themeMode: state.themeMode,
                  darkTheme: darkTheme,
                  home: const MainPage(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
