import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chance_app/ui/pages/sign_in_up/log_in/input_login_layout.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    String? errorText;
    switch (event.inputLoginLayout) {
      case InputLoginLayouts.email:
        if (text.trim().isEmpty &&
            !RegExp(r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b')
                .hasMatch(text)) {
          errorText = 'Невірний формат електронної пошти';
          emit(state.copyWith(errorEmail: errorText));
        } else {
          emit(state.copyWith(errorEmail: ""));
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
      ValidateForm event, Emitter<LoginState> emit) async {
    bool isValid = validate(emit);
    if (isValid) {
      await Repository()
          .sendLoginData(state.email, state.password)
          .then((value) {
        if (value==null) {
          Navigator.of(event.context)
              .pushNamedAndRemoveUntil("/", (route) => false);
        }else{
          emit(state.copyWith(errorEmail: value,errorPassword: value));
        }
      });
    }
  }

  bool validate(Emitter<LoginState> emit) {
    String text = state.email;
    String errorTextPassword = 'Пароль має бути 8 або більше символів',
        errorTextEmail = 'Невірний формат електронної пошти';
    text = state.email;
    if (text.isEmpty) {
      emit(state.copyWith(errorEmail: errorTextEmail));
      Fluttertoast.showToast(msg: errorTextEmail);
      return false;
    } else {
      if (!RegExp(r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b',
              caseSensitive: false)
          .hasMatch(text)) {
        emit(state.copyWith(errorEmail: errorTextEmail));
        Fluttertoast.showToast(msg: errorTextEmail);
        return false;
      } else {
        if (text.contains(".ru", text.length - 4) ||
            text.contains(".by", text.length - 4) ||
            text.contains(".рф", text.length - 4)) {
          emit(state.copyWith(errorEmail: errorTextEmail));
          Fluttertoast.showToast(msg: errorTextEmail);
          return false;
        } else {
          emit(state.copyWith(errorEmail: ""));
          text = state.password;
          if (text.trim().length < 8) {
            errorTextPassword = 'Пароль має бути 8 або більше символів';
          }
          if (text.trim().length > 14) {
            errorTextPassword = "Пароль має бути менше 14 символів";
          }
          emit(state.copyWith(errorEmail: errorTextEmail));
        }
      }
    }

    return true;
  }

  bool isEnglish(String input) {
    for (int i = 0; i < input.length; i++) {
      int charCode = input.codeUnitAt(i);
      // Check if the character code falls within the range of English keyboard characters
      if (!((charCode >= 65 && charCode <= 90) || // Uppercase letters A-Z
          (charCode >= 97 && charCode <= 122) || // Lowercase letters a-z
          (charCode >= 48 && charCode <= 57) || // Numbers 0-9
          (charCode == 32))) {
        // Space character
        return false;
      }
    }
    return true;
  }
}
