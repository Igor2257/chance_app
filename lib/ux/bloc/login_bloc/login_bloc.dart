import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chance_app/ui/pages/sign_in_up/log_in/input_login_layout.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<SaveEmail>(_onSaveEmail);
    on<SavePassword>(_onSavePassword);
    on<ValidateField>(_onValidateField);
    on<ValidateForm>(_onValidateForm);
  }

  FutureOr<void> _onSaveEmail(SaveEmail event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _onSavePassword(SavePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _onValidateField(
      ValidateField event, Emitter<LoginState> emit) {
    String text = event.text;
    switch (event.inputLoginLayout) {
      case InputLoginLayouts.email:
        emit(state.copyWith(errorEmail: validateEmail(text)??"", email: text));
        break;
      case InputLoginLayouts.password:
        emit(state.copyWith(
            errorPassword: validateFirstPassword(text)??"", password: text));
        break;
    }
  }

  FutureOr<void> _onValidateForm(
      ValidateForm event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true,email: event.email,password: event.password));
    bool isValid = validate(emit);
    if (isValid) {
      await Repository()
          .sendLoginData(state.email, state.password)
          .then((value) {
        if (value==null) {
          Navigator.of(event.context)
              .pushNamedAndRemoveUntil("/", (route) => false);
          emit(state.clear());
        }else{
          emit(state.copyWith(errorEmail: value,errorPassword: value,isLoading: false));
        }
      });
    }else{
      emit(state.copyWith(isLoading: false));
    }
  }

  bool validate(Emitter<LoginState> emit) {
    String? errorTextEmail = validateEmail(state.email),
        errorTextPassword = validateFirstPassword(state.password);
    if (errorTextEmail == null && errorTextPassword == null) {
      emit(state.copyWith(
          errorPassword: "", errorEmail: ""));
      return true;
    }
    emit(state.copyWith(
        errorPassword: errorTextPassword??"", errorEmail: errorTextEmail??""));
    return false;
  }

  String? validateEmail(String text) {
    if (text.trim().isEmpty) {
      return 'Невірний формат електронної пошти';
    }

    if (!RegExp(r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b',
            caseSensitive: false)
        .hasMatch(text)) {
      return 'Невірний формат електронної пошти';
    }
    if (text.trim().isNotEmpty &&
        text.trim().length > 4 &&
        (text.contains(".ru", text.length - 4) ||
            text.contains(".by", text.length - 4) ||
            text.contains(".рф", text.length - 4))) {
      return 'Невірний формат електронної пошти';
    }
    return null;
  }

  String? validateFirstPassword(String text) {
    if (text.trim().length >= 8) {
      if (text.trim().length <= 14) {
        return null;
      } else {
        return "Пароль має бути менше 14 символів";
      }
    } else {
      return 'Пароль має бути 8 або більше символів';
    }
  }
}
