part of 'sos_contacts_bloc.dart';

class SosContactsState {
  List<SosContactModel> contacts;

  SosContactsState({this.contacts = const []});

  SosContactsState copyWith({required List<SosContactModel> contacts}) {
    return SosContactsState(
      contacts: contacts,
    );
  }

  SosContactsState clear() {
    return SosContactsState(contacts: const []);
  }
}
