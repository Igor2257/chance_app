part of 'login_bloc.dart';

class LoginState {
  String phone, password;
  String errorPhone, errorPassword;

  LoginState({
    this.phone = "",
    this.password = "",
    this.errorPhone = "",
    this.errorPassword = "",
  });

  LoginState copyWith({
    String? phone,
    password,errorPhone,errorPassword,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      errorPhone: errorPhone ?? this.errorPhone,
      errorPassword: errorPassword ?? this.errorPassword,
    );
  }

  LoginState clear(){
    return LoginState(
      phone: "",
      password: "",
      errorPhone: "",
      errorPassword: "",
    );
  }
}
