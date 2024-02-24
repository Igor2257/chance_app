part of 'login_bloc.dart';

class LoginState {
  String email, password;
  String errorEmail, errorPassword;
  bool isLoading;

  LoginState({
    this.email = "",
    this.password = "",
    this.errorEmail = "",
    this.errorPassword = "",
    this.isLoading = false,
  });

  LoginState copyWith({
    String? email,
    password,errorEmail,errorPassword,
    bool? isLoading,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      errorEmail: errorEmail ?? this.errorEmail,
      errorPassword: errorPassword ?? this.errorPassword,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  LoginState clear(){
    return LoginState(
      email: "",
      password: "",
      errorEmail: "",
      errorPassword: "",
        isLoading:false,
    );
  }
}
