import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/service/interfaces/itheme_mode_service.dart';

import '../../../application_config.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final _appStorageService = locator<IThemeModeService>();

  SettingBloc()
      : super(SettingState(
            themeMode: locator<IThemeModeService>().getThemeMode())) {
    on<SettingThemeModeChanged>(_changeThemeMode);
  }

  Future<void> _changeThemeMode(
    SettingThemeModeChanged event,
    Emitter<SettingState> emit,
  ) async {
    await _appStorageService.setThemeMode(event.themeMode);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  void _error(Object e, Emitter<SettingState> emit) {
    emit(
      state.copyWith(
        success: false,
        message: 'Lỗi \n${e.toString()}',
      ),
    );
  }
}
