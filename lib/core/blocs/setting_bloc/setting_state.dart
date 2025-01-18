part of 'setting_bloc.dart';

class SettingState {
  final ThemeMode themeMode;
  final String? message;
  final bool? success;
  final bool loading;

  const SettingState({
    required this.themeMode,
    this.message,
    this.success,
    this.loading = false,
  });

  SettingState copyWith({
    ThemeMode? themeMode,
    String? message,
    bool? success,
    bool? loading,
  }) {
    return SettingState(
      themeMode: themeMode ?? this.themeMode,
      message: message,
      success: success,
      loading: loading ?? false,
    );
  }
}
