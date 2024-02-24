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
    on<ChangeUserGrantPermissionForProcessingPersonalData>(
        _onChangeUserGrantPermissionForProcessingPersonalData);
  }

  FutureOr<void> _onSaveFirstName(
      SaveFirstName event, Emitter<RegistrationState> emit) async {
  }

  FutureOr<void> _onSaveLastName(
      SaveLastName event, Emitter<RegistrationState> emit) async* {
    yield state.copyWith(lastName: event.lastName);
  }

  FutureOr<void> _onSavePhone(
      SavePhone event, Emitter<RegistrationState> emit) async* {
    yield state.copyWith(phone: event.phone);
  }

  FutureOr<void> _onSaveEmail(
      SaveEmail event, Emitter<RegistrationState> emit) async* {
    yield state.copyWith(email: event.email);
  }

  FutureOr<void> _onSavePasswordFirst(
      SavePasswordFirst event, Emitter<RegistrationState> emit) async* {
    yield state.copyWith(passwordFirst: event.passwordFirst);
  }

  FutureOr<void> _onSavePasswordSecond(
      SavePasswordSecond event, Emitter<RegistrationState> emit) async* {
    yield state.copyWith(passwordSecond: event.passwordSecond);
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
        emit(state.copyWith(lastName: text));
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
        if (text.trim().isEmpty) {
          errorText = 'Невірний формат номеру телефону';
          emit(state.copyWith(errorPhone: errorText));
          break;
        }
        if (!RegExp(r'^\+380\d{9}$').hasMatch(text)
        ) {
          errorText = 'Невірний формат номеру телефону';
          emit(state.copyWith(errorPhone: errorText));
        } else {
          emit(state.copyWith(errorPhone: ""));
        }
        break;
      case InputLayouts.email:
        emit(state.copyWith(email: text));
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
        if (text.trim().length >= 8) {
          if (text.trim().length <= 14) {
            errorText = "";
          } else {
            errorText = "Пароль має бути менше 14 символів";
          }
        } else {
          errorText = 'Пароль має бути 8 або більше символів';
        }
        emit(
            state.copyWith(passwordFirst: text, errorFirstPassword: errorText));
        break;
      case InputLayouts.lastPassword:
        emit(state.copyWith(passwordSecond: text));

        if (text.trim().length >= 8) {
          if (text.trim().length <= 14) {
            if (state.passwordFirst == text) {
              errorText = "";
            } else {
              errorText = "Паролі не співпадають";
            }
          } else {
            errorText = "Пароль має бути менше 14 символів";
          }
        } else {
          errorText = 'Пароль має бути 8 або більше символів';
        }

        emit(state.copyWith(
            passwordSecond: text, errorSecondPassword: errorText));

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
    if (!RegExp(r'^\+380\d{9}$').hasMatch(text)
    ){
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
    if (text.trim().isNotEmpty &&
        text.trim().length > 4 &&
        (text.contains(".ru", text.length - 4) ||
            text.contains(".by", text.length - 4) ||
            text.contains(".рф", text.length - 4))) {
      errorTextEmail = 'Невірний формат електронної пошти';
    }

    text = state.passwordFirst;

    if (text.trim().length >= 8) {
      if (text.trim().length <= 14) {
        errorTextFP = null;
      } else {
        errorTextFP = "Пароль має бути менше 14 символів";
      }
    } else {
      errorTextFP = 'Пароль має бути 8 або більше символів';
    }

    text = state.passwordSecond;

    if (text.trim().length >= 8) {
      if (text.trim().length <= 14) {
        if (state.passwordFirst == text) {
          errorTextLP = null;
        } else {
          errorTextFP = "Пароль має cпівпадати";
          errorTextLP = "Паролі не співпадають";
        }
      } else {
        errorTextLP = "Пароль має бути менше 14 символів";
      }
    } else {
      errorTextLP = 'Пароль має бути 8 або більше символів';
    }

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
}
