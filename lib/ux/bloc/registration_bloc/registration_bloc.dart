import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/input_register_layout.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationState()) {
    on<LoadData>(_onLoadData);
    on<SaveFirstName>(_onSaveFirstName);
    on<SaveLastName>(_onSaveLastName);
    on<SavePhone>(_onSavePhone);
    on<SaveEmail>(_onSaveEmail);
    on<SavePasswordFirst>(_onSavePasswordFirst);
    on<SavePasswordSecond>(_onSavePasswordSecond);
    on<IncreaseCurrentStep>(_onIncreaseCurrentStep);
    on<DecreaseCurrentStep>(_onDecreaseCurrentStep);
    on<Dispose>(_onDispose);
    on<ValidateForm>(_onValidateForm);
    on<ChangeUserGrantPermissionForProcessingPersonalData>(
        _onChangeUserGrantPermissionForProcessingPersonalData);
  }

  FutureOr<void> _onSaveFirstName(
      SaveFirstName event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(firstName: event.firstName));
  }

  FutureOr<void> _onSaveLastName(
      SaveLastName event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(lastName: event.lastName));
  }

  FutureOr<void> _onSavePhone(
      SavePhone event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  FutureOr<void> _onSaveEmail(
      SaveEmail event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _onSavePasswordFirst(
      SavePasswordFirst event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(passwordFirst: event.passwordFirst));
  }

  FutureOr<void> _onSavePasswordSecond(
      SavePasswordSecond event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(passwordSecond: event.passwordSecond));
  }

  FutureOr<void> _onIncreaseCurrentStep(
      IncreaseCurrentStep event, Emitter<RegistrationState> emit) {
    int currentStep = state.currentStep+1;
    if (currentStep < 2) {

      state.pageController!.animateToPage(currentStep,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      double plusPercentage = 0.33;
      if (currentStep == 1) {
        plusPercentage = 0.34;
      }
      if (validate(emit)) {
        emit(state.copyWith(
            percentage: state.percentage + plusPercentage,
            currentStep: currentStep));
      }
    } else {
      if (validate(emit)) {
        Navigator.of(event.context)
            .pushNamedAndRemoveUntil("/subscription_page", (route) => false);
      }
    }
  }

  FutureOr<void> _onDecreaseCurrentStep(
      DecreaseCurrentStep event, Emitter<RegistrationState> emit) {
    int currentStep = state.currentStep-1;
    if (currentStep > -1) {

      state.pageController!.animateToPage(currentStep ,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      double plusPercentage = 0.33;
      if (currentStep == 1) {
        plusPercentage = 0.34;
      }
      emit(state.copyWith(
          percentage: state.percentage - plusPercentage,
          currentStep: currentStep ));
    }
  }

  FutureOr<void> _onDispose(Dispose event, Emitter<RegistrationState> emit) {
    state.pageController!.dispose();
    emit(state.clear());
  }

  FutureOr<void> _onValidateForm(
      ValidateForm event, Emitter<RegistrationState> emit) {
    String text = event.text;
    String? errorText;
    switch (event.inputLayouts) {
      case InputLayouts.lastName:
        emit(state.copyWith(lastName: text));
        add(SaveLastName(lastName: text));
        if (text.trim().isEmpty) {
          errorText = 'Ім`я порожнє';
          emit(state.copyWith(errorLastName: errorText));
          break;
        } else {
          emit(state.copyWith(errorLastName: ""));
        }

        break;
      case InputLayouts.firstName:
        emit(state.copyWith(firstName: text));
        add(SaveFirstName(firstName: text));
        if (text.trim().isEmpty) {
          errorText = 'Прізвище порожнє';
          emit(state.copyWith(errorFirstName: errorText));
          break;
        } else {
          emit(state.copyWith(errorFirstName: ""));
        }
        break;
      case InputLayouts.phone:
        emit(state.copyWith(phone: text));
        add(SavePhone(phone: text));
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
      case InputLayouts.email:
        emit(state.copyWith(email: text));
        add(SaveEmail(email: text));
        if (text.trim().isEmpty) {
          errorText = 'Невірний формат електронної пошти';
          emit(state.copyWith(errorEmail: errorText));
          break;
        }
        if (!RegExp(r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b',
                caseSensitive: false)
            .hasMatch(text)) {
          errorText = 'Невірний формат електронної пошти';
          emit(state.copyWith(errorEmail: errorText));
          break;
        } else {
          emit(state.copyWith(errorEmail: ""));
        }

        break;
      case InputLayouts.firstPassword:
        emit(state.copyWith(passwordFirst: text));
        add(SavePasswordFirst(passwordFirst: text));
        if (text.trim().isEmpty ||
            (text.trim().isNotEmpty && text.trim().length < 8)) {
          errorText = 'Пароль має бути 8 або більше символів';
          emit(state.copyWith(errorFirstPassword: errorText));
          break;
        } else {
          emit(state.copyWith(errorFirstPassword: ""));
        }
        break;
      case InputLayouts.lastPassword:
        emit(state.copyWith(passwordSecond: text));
        add(SavePasswordSecond(passwordSecond: text));
        if (text.trim().isEmpty ||
            (text.trim().isNotEmpty && text.trim().length < 8)) {
          errorText = 'Пароль має бути 8 або більше символів';
          emit(state.copyWith(errorSecondPassword: errorText));
          break;
        } else if (state.passwordFirst != state.passwordSecond) {
          errorText = 'Пароль не співпадає';
          emit(state.copyWith(errorSecondPassword: errorText));
        } else {
          emit(state.copyWith(errorSecondPassword: ""));
        }

        break;
    }
  }

  FutureOr<void> _onLoadData(LoadData event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(pageController: PageController(initialPage: 0)));
  }

  FutureOr<void> _onChangeUserGrantPermissionForProcessingPersonalData(
      ChangeUserGrantPermissionForProcessingPersonalData event,
      Emitter<RegistrationState> emit) {
    emit(state.copyWith(
        isUserGrantPermissionForProcessingPersonalData: !state.isUserGrantPermissionForProcessingPersonalData));
  }

  bool validate(Emitter<RegistrationState> emit) {
    String text = state.lastName;
    String? errorTextFN,
        errorTextLN,
        errorTextEmail,
        errorTextPhone,
        errorTextFP,
        errorTextLP;
    if (text.trim().isEmpty) {
      errorTextLN = 'Ім`я порожнє';
    }

    text = state.firstName;
    if (text.trim().isEmpty) {
      errorTextFN = 'Прізвище порожнє';
    }

    text = state.phone;
    if (text.trim().isEmpty) {
      errorTextPhone = 'Невірний формат номеру телефону';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(text)) {
      errorTextPhone = 'Невірний формат номеру телефону';
    }

    text = state.email;
    if (text.trim().isEmpty) {
      errorTextEmail = 'Невірний формат електронної пошти';
    }

    if (!RegExp(r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b',
            caseSensitive: false)
        .hasMatch(text)) {
      errorTextEmail = 'Невірний формат електронної пошти';
    }

    text = state.passwordFirst;
    if (text.trim().isEmpty ||
        (text.trim().isNotEmpty && text.trim().length < 8)) {
      errorTextFP = 'Пароль має бути 8 або більше символів';
    }

    text = state.passwordSecond;
    if (text.trim().isEmpty ||
        (text.trim().isNotEmpty && text.trim().length < 8)) {
      errorTextLP = 'Пароль має бути 8 або більше символів';
    } else if (state.passwordFirst != state.passwordSecond) {
      errorTextLP = 'Пароль не співпадає';
    }

    emit(state.copyWith(
        errorLastName: errorTextLN,
        errorFirstName: errorTextFN,
        errorEmail: errorTextEmail,
        errorPhone: errorTextPhone,
        errorFirstPassword: errorTextFP,
        errorSecondPassword: errorTextLP));
    if (errorTextLN == null || errorTextLN.trim().isEmpty) {
      if (errorTextFN == null || errorTextFN.trim().isEmpty) {
        if (errorTextEmail == null || errorTextEmail.trim().isEmpty) {
          if (errorTextPhone == null || errorTextPhone.trim().isEmpty) {
            if (errorTextFP == null || errorTextFP.trim().isEmpty) {
              if (errorTextLP == null || errorTextLP.trim().isEmpty) {
                if (state.isUserGrantPermissionForProcessingPersonalData) {
                  return true;
                } else {
                  Fluttertoast.showToast(
                      msg:
                          "Вам необхідно надати дозвіл на обробку персольних даних");
                  state.pageController!.animateToPage(2,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                  emit(state.copyWith(currentStep: 2, percentage: 1));
                }
              } else {
                state.pageController!.animateToPage(2,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
                emit(state.copyWith(currentStep: 2, percentage: 1));
              }
            } else {
              state.pageController!.animateToPage(2,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
              emit(state.copyWith(currentStep: 2, percentage: 1));
            }
          } else {
            state.pageController!.animateToPage(1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
            emit(state.copyWith(currentStep: 1, percentage: 0.66));
          }
        } else {
          state.pageController!.animateToPage(1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
          emit(state.copyWith(currentStep: 1, percentage: 0.66));
        }
      } else {
        state.pageController!.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
        emit(state.copyWith(currentStep: 0, percentage: 0.33));
      }
    } else {
      state.pageController!.animateToPage(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      emit(state.copyWith(currentStep: 0, percentage: 0.33));
    }
    return false;
  }
}
