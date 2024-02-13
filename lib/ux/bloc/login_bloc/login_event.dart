part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class SavePhone extends LoginEvent{
  final String phone;

  SavePhone({required this.phone});
}
class SavePassword extends LoginEvent{
  final String password;

  SavePassword({required this.password});
}
class ValidateField extends LoginEvent{
final InputLoginLayouts inputLoginLayout;
final String text;

ValidateField({required this.inputLoginLayout, required this.text});
}
class ValidateForm extends LoginEvent{
final BuildContext context;

  ValidateForm({required this.context});
}
