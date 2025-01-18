part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class SettingThemeModeChanged extends SettingEvent {
  final ThemeMode themeMode;
  const SettingThemeModeChanged({
    required this.themeMode,
  });
  @override
  List<Object> get props => [themeMode];
}

class SettingProfileImageChanged extends SettingEvent {
  final File image;
  const SettingProfileImageChanged({
    required this.image,
  });
}
