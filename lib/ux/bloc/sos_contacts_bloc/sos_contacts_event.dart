part of 'sos_contacts_bloc.dart';

@immutable
abstract class SosContactsEvent {}

class SaveContact extends SosContactsEvent {
  final SosGroupModel contactModel;

  SaveContact({required this.contactModel});
}

class DeleteContact extends SosContactsEvent {
  final List<String> ids;

  DeleteContact({required this.ids});
}

class EditContact extends SosContactsEvent {
  final SosGroupModel oldContact;
  final SosGroupModel newContact;

  EditContact({required this.oldContact, required this.newContact});
}

class LoadSosContactsEvent extends SosContactsEvent {}
