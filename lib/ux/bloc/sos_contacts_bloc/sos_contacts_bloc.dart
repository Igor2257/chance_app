import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:chance_app/ux/model/sos_group_model.dart';
import 'package:flutter/material.dart';

part 'sos_contacts_state.dart';
part 'sos_contacts_event.dart';

class SosContactsBloc extends Bloc<SosContactsEvent, SosContactsState> {
  List<SosContactModel> contacts = [
    SosContactModel(name: 'TestContact1', phone: '+380951234567'),
    SosContactModel(name: 'TestContact2', phone: '+380954444444'),
    SosContactModel(name: 'TestContact3', phone: '+380954445555'),
  ];

  SosContactsBloc() : super(SosContactsState(contacts: [], groups: [])) {
    on<SaveContact>(_onSaveContacts);
    on<DeleteContact>(_onDeleteContact);
    on<EditContact>(_onEditContact);
    on<SaveGroup>(_onSaveGroup);
  }

  FutureOr<void> _onSaveGroup(SaveGroup event, Emitter<SosContactsState> emit) {
    emit(state.copyWith(groups: List.of(state.groups)..add(event.group)));
  }

  FutureOr<void> _onSaveContacts(
      SaveContact event, Emitter<SosContactsState> emit) {
    for (var element in event.contacts) {
      contacts.add(element);
    }

    emit(state.copyWith(contacts: contacts));
  }

  FutureOr<void> _onDeleteContact(
      DeleteContact event, Emitter<SosContactsState> emit) {
    for (var element in event.contacts) {
      contacts.remove(element);
    }

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
}
