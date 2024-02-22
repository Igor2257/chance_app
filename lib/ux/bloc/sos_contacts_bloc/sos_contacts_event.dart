part of 'sos_contacts_bloc.dart';

@immutable
abstract class SosContactsEvent {}

class SaveContact extends SosContactsEvent {
  final SosContactModel contactModel;

  SaveContact({required this.contactModel});
}

class DeleteContact extends SosContactsEvent {
  final List<SosContactModel> contacts;

  DeleteContact({required this.contacts});
}
