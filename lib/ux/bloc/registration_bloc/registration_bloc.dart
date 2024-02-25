import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/input_register_layout.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/registration_page.dart';
import 'package:chance_app/ux/repository.dart';
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
    on<ClearData>(_onClearData);
    on<ChangeUserGrantPermissionForProcessingPersonalData>(
        _onChangeUserGrantPermissionForProcessingPersonalData);
  }

  FutureOr<void> _onSaveFirstName(
      SaveFirstName event, Emitter<RegistrationState> emit) async {
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
      IncreaseCurrentStep event, Emitter<RegistrationState> emit) async {
    emit(state.copyWith(isLoading: true));

    if (state.registrationPages != RegistrationPages.third) {
      int index = RegistrationPages.values.indexOf(state.registrationPages) + 1;
      RegistrationPages registrationPages = RegistrationPages.values[index];

      state.pageController!.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      double plusPercentage = 0.33;
      if (index == 1) {
        plusPercentage = 0.34;
      }
      if (index - 1 == 0) {
        emit(state.copyWith(firstName: event.second, lastName: event.first));
      } else if (index - 1 == 1) {
        emit(state.copyWith(email: event.second));
      }
      if (validate(emit)) {
        emit(state.copyWith(
            percentage: state.percentage + plusPercentage,
            registrationPages: registrationPages));
      }
    } else {
      emit(state.copyWith(
          passwordSecond: event.second, passwordFirst: event.first));
      if (validate(emit)) {
        await Repository()
            .sendRegisterData(state.lastName, state.firstName, state.phone,
                state.email, state.passwordFirst)
            .then((value) {
          if (value == null) {
            Navigator.of(event.context)
                .pushNamedAndRemoveUntil("/enter_code", (context) => true);
          }
        });
      }
    }
    emit(state.copyWith(isLoading: false));
  }

  FutureOr<void> _onDecreaseCurrentStep(
      DecreaseCurrentStep event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(isLoading: true));

    if (state.registrationPages != RegistrationPages.first) {
      int index = RegistrationPages.values.indexOf(state.registrationPages) - 1;
      RegistrationPages registrationPages = RegistrationPages.values[index];
      state.pageController!.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      double plusPercentage = 0.33;
      if (index == 1) {
        plusPercentage = 0.34;
      }
      emit(state.copyWith(
          percentage: state.percentage - plusPercentage,
          registrationPages: registrationPages));
    }
    emit(state.copyWith(isLoading: false));
  }

  FutureOr<void> _onDispose(Dispose event, Emitter<RegistrationState> emit) {
    state.pageController!.dispose();
    //emit(state.clear());
  }

  FutureOr<void> _onValidateForm(
      ValidateForm event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(isLoading: true));
    String text = event.text;
    String? errorText;
    switch (event.inputLayouts) {
      case InputLayouts.lastName:
        emit(state.copyWith(
            lastName: text, errorLastName: validateLastName(text) ?? ""));
        break;
      case InputLayouts.firstName:
        emit(state.copyWith(
            firstName: text, errorFirstName: validateFirstName(text) ?? ""));

        break;
      case InputLayouts.phone:
        emit(
            state.copyWith(phone: text, errorPhone: validatePhone(text) ?? ""));
        break;
      case InputLayouts.email:
        emit(
            state.copyWith(email: text, errorEmail: validateEmail(text) ?? ""));

        break;
      case InputLayouts.firstPassword:
        emit(state.copyWith(
            passwordFirst: text,
            errorFirstPassword: validateFirstPassword(text) ?? ""));

        break;
      case InputLayouts.lastPassword:
        emit(state.copyWith(
            passwordSecond: text,
            errorSecondPassword: validateSecondPassword(text) ?? ""));
        break;
    }
    emit(state.copyWith(isLoading: false));
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
    text = state.firstName;
    errorTextFN = validateFirstName(text);
    text = state.lastName;
    errorTextLN = validateLastName(text);

    text = state.phone;
    errorTextPhone = validatePhone(text);

    text = state.email;
    errorTextEmail = validateEmail(text);

    text = state.passwordFirst;

    errorTextFP = validateFirstPassword(text);

    text = state.passwordSecond;
    errorTextLP = validateSecondPassword(text);

    int index = RegistrationPages.values.indexOf(state.registrationPages);
    if (index == 0) {
      emit(state.copyWith(
        errorLastName: errorTextLN,
        errorFirstName: errorTextFN,
      ));
    } else if (index == 1) {
      emit(state.copyWith(
        errorEmail: errorTextEmail,
        errorPhone: errorTextPhone,
      ));
    } else if (index == 2) {
      emit(state.copyWith(
        errorFirstPassword: errorTextFP,
        errorSecondPassword: errorTextLP,
      ));
    }

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
                  emit(state.copyWith(
                      registrationPages: RegistrationPages.values[2],
                      percentage: 1));
                }
              } else {
                state.pageController!.animateToPage(2,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
                emit(state.copyWith(
                    registrationPages: RegistrationPages.values[2],
                    percentage: 1));
              }
            } else {
              state.pageController!.animateToPage(2,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
              emit(state.copyWith(
                  registrationPages: RegistrationPages.values[2],
                  percentage: 1));
            }
          } else {
            state.pageController!.animateToPage(1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
            emit(state.copyWith(
                registrationPages: RegistrationPages.values[1],
                percentage: 0.66));
          }
        } else {
          state.pageController!.animateToPage(1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
          emit(state.copyWith(
              registrationPages: RegistrationPages.values[1],
              percentage: 0.66));
        }
      } else {
        state.pageController!.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
        emit(state.copyWith(
            registrationPages: RegistrationPages.values[0], percentage: 0.33));
      }
    } else {
      state.pageController!.animateToPage(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      emit(state.copyWith(
          registrationPages: RegistrationPages.values[0], percentage: 0.33));
    }
    return false;
  }

  FutureOr<void> _onClearData(
      ClearData event, Emitter<RegistrationState> emit) {
    emit(state.clear());
  }

  String? validateFirstName(String text) {
    if (text.trim().isEmpty) {
      return 'Прізвище порожнє';
    }
    if (text.trim().length < 2) {
      return 'Прізвище повинно мати не менше 2 символів';
    }

    if (text.trim().length > 50) {
      return 'Прізвище повинно бути не більше 50 символів';
    }
    RegExp regex = RegExp(r"^[a-zA-Zа-яА-ЯІіЇїЄєҐґ\s\'-]+$");
    if (!regex.hasMatch(text)) {
      return 'Недопустимі символи. Введіть латиницю, кирилицю, пробіл, апостроф і/або дефіс';
    }
    return null;
  }

  String? validateLastName(String text) {
    if (text.trim().isEmpty) {
      return 'Ім`я порожнє';
    }

    if (text.trim().length < 2) {
      return 'Ім’я повинно мати не менше 2 символів';
    }

    if (text.trim().length > 30) {
      return 'Ім’я повинно бути не більше 30 символів';
    }
    RegExp regex = RegExp(r"^[a-zA-Zа-яА-ЯІіЇїЄєҐґ\s\'-]+$");
    if (!regex.hasMatch(text)) {
      return 'Недопустимі символи. Введіть латиницю, кирилицю, пробіл, апостроф і/або дефіс';
    }

    return null;
  }

  String? validatePhone(String text) {
    if (text.trim().isEmpty) {
      return 'Невірний формат номеру телефону';
    }
    if (!RegExp(r'^\+380\d{9}$').hasMatch(text)) {
      return 'Невірний формат номеру телефону';
    }
    return null;
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

  String? validateSecondPassword(String text) {
    if (text.trim().length >= 8) {
      if (text.trim().length <= 14) {
        if (state.passwordFirst == text) {
          return null;
        } else {
          return "Паролі не співпадають";
        }
      } else {
        return "Пароль має бути менше 14 символів";
      }
    } else {
      return 'Пароль має бути 8 або більше символів';
    }
  }
}
