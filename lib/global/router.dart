// import 'package:flutter/material.dart';
// import 'package:vivu_app/ui/screens/forgot_password_screen/forgot_password_screen.dart';
// import 'package:vivu_app/ui/screens/forgot_password_screen/pages/receive_otp_screen/receive_otp_screen.dart';
// import 'package:vivu_app/ui/screens/forgot_password_screen/pages/verify_otp_screen/verify_otp_screen.dart';
// import 'package:vivu_app/ui/screens/home_screen/pages/list_savings_screen/savings_details_screen/savings_details_screen.dart';
// import 'package:vivu_app/ui/screens/home_screen/pages/profile_screen/pages/personal_information_screen/personal_info_screen.dart';
// import 'package:vivu_app/ui/screens/loading_screen/loading_screen.dart';
//
// import '../ui/screens/theme_mode_setting_screen/theme_mode_setting_screen.dart';
//
// class MyRouter {
//   static const String home = '/home';
//   static const String login = '/login';
//   static const String loading = '/loading';
//   static const String verifyOtp = '/verifyOtp';
//   static const String register = '/register';
//   static const String forgotPassword = '/forgotPassword';
//   static const String themeModeSetting = '/themeModeSetting';
//   static const String languageSetting = '/languageSetting';
//   static const String changePassword = '/changePassword';
//   static const String inputNewPassword = '/inputNewPassword';
//   static const String receiveOtp = '/receiveOtp';
//   static const String personalInfo = '/personalInfo';
//   static const String savingsDetails = '/savingsDetails';
//
//   static PageRouteBuilder _buildRouteNavigationWithoutEffect(
//     RouteSettings settings,
//     Widget widget,
//   ) {
//     return PageRouteBuilder(
//       pageBuilder: (_, __, ___) => widget,
//       transitionDuration: Duration.zero,
//       settings: settings,
//     );
//   }
//
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case loading:
//         return _buildRouteNavigationWithoutEffect(
//           settings,
//           const LoadingScreen(),
//         );
//       case login:
//         return _buildRouteNavigationWithoutEffect(
//           settings,
//           const LoginScreen(),
//         );
//       case forgotPassword:
//         return _buildRouteNavigationWithoutEffect(
//           settings,
//           const ForgotPasswordScreen(),
//         );
//       case home:
//         return _buildRouteNavigationWithoutEffect(
//           settings,
//           HomeScreen(
//             userInfo: settings.arguments as UserInfoDto,
//           ),
//         );
//       case themeModeSetting:
//         return _buildRouteNavigationWithoutEffect(
//           settings,
//           const ThemeModeSettingScreen(),
//         );
//       default:
//         return _buildRouteNavigationWithoutEffect(
//           settings,
//           Scaffold(
//             body: Center(
//               child: Text('No route found: ${settings.name}.'),
//             ),
//           ),
//         );
//     }
//   }
//
//   static void onRouteChanged(String screenName) {
//     if (['', null].contains(screenName)) {
//       return;
//     }
//   }
// }
