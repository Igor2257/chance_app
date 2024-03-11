import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:chance_app/ux/repository/sos_repository.dart';
import 'package:flutter/material.dart';

part 'sos_contacts_state.dart';
part 'sos_contacts_event.dart';

class SosContactsBloc extends Bloc<SosContactsEvent, SosContactsState> {
  final SosRepository sosRepository = SosRepository();
  List<SosGroupModel> contacts = [
    // const SosContactModel(name: 'TestContact1', phone: '+380951234567'),
    // const SosContactModel(name: 'TestContact2', phone: '+380954444444'),
    // const SosContactModel(name: 'TestContact3', phone: '+380954445555'),
  ];
  SosContactsBloc() : super(SosContactsState()) {
    on<SaveContact>(_onSaveContact);
    on<DeleteContact>(_onDeleteContact);
    on<EditContact>(_onEditContact);
    on<LoadSosContactsEvent>(_onLoadContacts);
  }

  FutureOr<void> _onLoadContacts(
      LoadSosContactsEvent event, Emitter<SosContactsState> emit) async {
    try {
      final List<SosGroupModel>? loadedContacts =
          await sosRepository.loadContacts();
      contacts = loadedContacts ?? [];
      emit(state.copyWith(contacts: contacts));
    } catch (error) {
      // emit(SosContactsError(error.toString())); // Emit error state
    }
  }

  FutureOr<void> _onSaveContact(
      SaveContact event, Emitter<SosContactsState> emit) {
    sosRepository.saveContact(event.contactModel).then((value) {
      if (value != null) contacts.add(value);
      emit(state.copyWith(contacts: contacts));
    });
  }

  FutureOr<void> _onDeleteContact(
      DeleteContact event, Emitter<SosContactsState> emit) {
    sosRepository.removeContact(event.ids.first);
    contacts
        .removeWhere((element) => element.contacts[0].id == event.ids.first);

    emit(state.copyWith(contacts: contacts));
  }

  FutureOr<void> _onEditContact(
      EditContact event, Emitter<SosContactsState> emit) {
    final index = contacts.indexOf(event.oldContact);

    if (index != -1) {
      contacts[index] = event.newContact;
      emit(state.copyWith(contacts: contacts));
      print('Contact edited: $event.oldContact -> $event.newContact');
    }
  }

  loadContacts() {}
}
