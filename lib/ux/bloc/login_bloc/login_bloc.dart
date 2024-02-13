import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chance_app/ui/pages/sign_in_up/log_in/input_login_layout.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<SavePhone>(_onSavePhone);
    on<SavePassword>(_onSavePassword);
    on<ValidateField>(_onValidateField);
    on<ValidateForm>(_onValidateForm);
  }

  FutureOr<void> _onSavePhone(SavePhone event, Emitter<LoginState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  FutureOr<void> _onSavePassword(SavePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _onValidateField(
      ValidateField event, Emitter<LoginState> emit) {
    String text = event.text;
    String? errorText;
    switch (event.inputLoginLayout) {
      case InputLoginLayouts.phone:
        if (text.trim().isEmpty) {
          errorText = 'Невірний формат номеру телефону';
          emit(state.copyWith(errorPhone: errorText));
          break;
        }
        if (!RegExp(r'^[0-9]{10}$').hasMatch(text)) {
          errorText = 'Невірний формат номеру телефону';
          emit(state.copyWith(errorPhone: errorText));
        } else {
          emit(state.copyWith(errorPhone: ""));
        }
        break;
      case InputLoginLayouts.password:
        if (text.trim().isEmpty ||
            (text.trim().isNotEmpty && text.trim().length < 8)) {
          errorText = 'Пароль має бути 8 або більше символів';
          emit(state.copyWith(errorPassword: errorText));
          break;
        } else {
          emit(state.copyWith(errorPassword: ""));
        }
        break;
    }
  }

  FutureOr<void> _onValidateForm(
      ValidateForm event, Emitter<LoginState> emit) {
    if(validate(emit)){
      Navigator.of(event.context).pushNamedAndRemoveUntil("/", (route) => false);
    }
  }

  bool validate(Emitter<LoginState> emit) {
    String text = state.phone;
    String? errorTextPhone, errorTextPassword;

    text = state.phone;
    if (text.trim().isEmpty) {
      errorTextPhone = 'Невірний формат номеру телефону';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(text)) {
      errorTextPhone = 'Невірний формат номеру телефону';
    }

    text = state.password;
    if (text.trim().isEmpty ||
        (text.trim().isNotEmpty && text.trim().length < 8)) {
      errorTextPassword = 'Пароль має бути 8 або більше символів';
    }

    emit(state.copyWith(
        errorPhone: errorTextPhone, errorPassword: errorTextPassword));
    if (errorTextPhone == null || errorTextPhone.trim().isEmpty) {
      if (errorTextPassword == null || errorTextPassword.trim().isEmpty) {
        return true;
      }
    }

    return false;
  }
}
