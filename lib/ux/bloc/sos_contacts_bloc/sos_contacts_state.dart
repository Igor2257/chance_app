// part of 'sos_contacts_bloc.dart';

// class SosContactsState {
//   List<SosContactModel> contacts;

//   SosContactsState({this.contacts = const []});

//   SosContactsState copyWith(
//       {required List<SosContactModel> contacts, required List groups}) {
//     return SosContactsState(
//       contacts: contacts,
//     );
//   }

//   SosContactsState clear() {
//     return SosContactsState(contacts: const []);
//   }
// }

part of 'sos_contacts_bloc.dart';

class SosContactsState {
  List<SosContactModel> contacts;
  List<SosGroupModel> groups;

  SosContactsState({required this.contacts, required this.groups});

  factory SosContactsState.initial() {
    return SosContactsState(contacts: [], groups: []);
  }

  SosContactsState copyWith({
    List<SosContactModel>? contacts,
    List<SosGroupModel>? groups,
  }) {
    return SosContactsState(
      contacts: contacts ?? this.contacts,
      groups: groups ?? this.groups,
    );
  }

  SosContactsState clear() {
    return SosContactsState(contacts: [], groups: []);
  }
}
