import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:personal_portfolio/pages/portfolio_page.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'application_config.dart';
import 'Global/locale.dart';
import 'core/blocs/setting_bloc/setting_bloc.dart';
import 'theme/editorial_colors.dart';
import 'theme/editorial_type.dart';

void main() {
  mainDelegate();
}

Future<void> mainDelegate() async {
  await initializeAppConfig();

  // Reveal-on-scroll should fire promptly rather than on the package's
  // half-second default, which reads as a lag on a fast scroll.
  VisibilityDetectorController.instance.updateInterval =
      const Duration(milliseconds: 100);

  runApp(
    EasyLocalization(
      supportedLocales: MyLocale.myLocales.map((e) => e.locale).toList(),
      path: 'assets/translations',
      child: const MyApp(),
    ),
  );
}

/// The editorial design is light-only — there is no dark variant of the site,
/// only the one dark section inside it.
final ThemeData editorialTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: EditorialColors.canvas,
  canvasColor: EditorialColors.canvas,
  fontFamily: EditorialType.display,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  colorScheme: const ColorScheme.light(
    surface: EditorialColors.surface,
    primary: EditorialColors.ink,
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 900),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<SettingBloc>(create: (_) => SettingBloc()),
          ],
          child: BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              return GetMaterialApp(
                title: 'Huynh Duy Khang — Mobile Engineer',
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                theme: editorialTheme,
                themeMode: ThemeMode.light,
                home: const PortfolioPage(),
              );
            },
          ),
        );
      },
    );
  }
}
