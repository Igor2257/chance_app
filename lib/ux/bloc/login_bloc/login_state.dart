part of 'login_bloc.dart';

class LoginState {
  String email, password;
  String errorEmail, errorPassword;

  LoginState({
    this.email = "",
    this.password = "",
    this.errorEmail = "",
    this.errorPassword = "",
  });

  LoginState copyWith({
    String? email,
    password,errorEmail,errorPassword,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      errorEmail: errorEmail ?? this.errorEmail,
      errorPassword: errorPassword ?? this.errorPassword,
    );
  }

  LoginState clear(){
    return LoginState(
      email: "",
      password: "",
      errorEmail: "",
      errorPassword: "",
    );
  }
}
