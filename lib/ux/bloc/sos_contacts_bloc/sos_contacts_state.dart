part of 'sos_contacts_bloc.dart';

class SosContactsState {
  List<SosGroupModel> contacts;

  SosContactsState({this.contacts = const []});

  SosContactsState copyWith({required List<SosGroupModel> contacts}) {
    return SosContactsState(
      contacts: contacts,
    );
  }

  SosContactsState clear() {
    return SosContactsState(contacts: const []);
  }
}
