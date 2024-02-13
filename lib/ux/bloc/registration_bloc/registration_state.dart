part of 'registration_bloc.dart';

class RegistrationState {
  String firstName, lastName, phone, email, passwordFirst, passwordSecond;
  int currentStep = 0;
  double percentage;
  PageController? pageController = PageController(initialPage: 0);

  String? errorLastName,errorFirstName,errorPhone,errorEmail,errorFirstPassword,errorSecondPassword;
  bool isUserGrantPermissionForProcessingPersonalData;
  RegistrationState({
    this.firstName = "",
    this.lastName = "",
    this.phone = "",
    this.email = "",
    this.passwordFirst = "",
    this.passwordSecond = "",
    this.currentStep = 0,
    this.percentage = 0.33,
    this.errorLastName,
    this.errorFirstName,
    this.errorPhone,
    this.errorEmail,
    this.errorFirstPassword,
    this.errorSecondPassword,
    this.pageController,
    this.isUserGrantPermissionForProcessingPersonalData=false,
  });

  RegistrationState copyWith({
    String? firstName,
    lastName,
    phone,
    email,
    passwordFirst,
    passwordSecond,
    int? currentStep,
    double? percentage,
    String? errorLastName,errorFirstName,errorPhone,errorEmail,errorFirstPassword,errorSecondPassword,
    PageController? pageController,
    bool? isUserGrantPermissionForProcessingPersonalData,
  }) {
    return RegistrationState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      passwordFirst: passwordFirst ?? this.passwordFirst,
      passwordSecond: passwordSecond ?? this.passwordSecond,
      currentStep: currentStep ?? this.currentStep,
      percentage: percentage ?? this.percentage,
      errorLastName: errorLastName ?? this.errorLastName,
      errorFirstName: errorFirstName ?? this.errorFirstName,
      errorPhone: errorPhone ?? this.errorPhone,
      errorEmail: errorEmail ?? this.errorEmail,
      errorFirstPassword: errorFirstPassword ?? this.errorFirstPassword,
      errorSecondPassword: errorSecondPassword ?? this.errorSecondPassword,
      pageController: pageController ?? this.pageController,
      isUserGrantPermissionForProcessingPersonalData: isUserGrantPermissionForProcessingPersonalData ?? this.isUserGrantPermissionForProcessingPersonalData,
    );
  }
  RegistrationState clear(){
    return RegistrationState(
      firstName: "",
      lastName:"",
      phone: "",
      email: "",
      passwordFirst: "",
      passwordSecond:"",
      currentStep: 0,
      percentage: 0.33,
      errorLastName: null,
      errorFirstName: null,
      errorPhone: null,
      errorEmail: null,
      errorFirstPassword: null,
      errorSecondPassword:null,
      pageController:null,
      isUserGrantPermissionForProcessingPersonalData:false,
    );
  }
}
