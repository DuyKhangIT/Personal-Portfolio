import 'package:flutter/material.dart';

class MyLocale {
  final String name;
  final Locale locale;
  final String imageUri;
  const MyLocale({
    required this.locale,
    required this.name,
    required this.imageUri,
  });

  static const List<MyLocale> myLocales = [
    MyLocale(
      locale: Locale('en', 'US'),
      name: 'English',
      imageUri: 'assets/images/png/en.png',
    ),
    MyLocale(
      locale: Locale('vi', 'VN'),
      name: 'Vietnam',
      imageUri: 'assets/images/png/vi.png',
    ),
  ];
}
