import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:chance_app/ux/repository/sos_repository.dart';
import 'package:flutter/material.dart';

part 'sos_contacts_event.dart';

part 'sos_contacts_state.dart';

class SosContactsBloc extends Bloc<SosContactsEvent, SosContactsState> {
  SosContactsBloc() : super(SosContactsState()) {
    on<SaveContact>(_onSaveContact);
    on<DeleteContact>(_onDeleteContact);
    on<EditContact>(_onEditContact);
    on<LoadSosContactsEvent>(_onLoadContacts);
  }

  FutureOr<void> _onLoadContacts(
      LoadSosContactsEvent event, Emitter<SosContactsState> emit) async {
    try {
      await SosRepository().loadContacts().then((value) {
        if (value != null) {
          emit(state.copyWith(contacts: value));
        }
      });
    } catch (error) {
      // emit(SosContactsError(error.toString())); // Emit error state
    }
  }

  FutureOr<void> _onSaveContact(
      SaveContact event, Emitter<SosContactsState> emit) async {
    await SosRepository().saveContact(event.contactModel).then((value) {
      if (value != null) {
        List<SosGroupModel> list = state.contacts;
        list.add(event.contactModel);
        emit(state.copyWith(contacts: list));
      }
    });
  }

  FutureOr<void> _onDeleteContact(
      DeleteContact event, Emitter<SosContactsState> emit) async {
    await SosRepository().removeContact(event.ids.first).then((value) {
      if (value == null) {
        List<SosGroupModel> list = state.contacts;
        list.removeWhere(
            (element) => element.contacts[0].id == event.ids.first);
        emit(state.copyWith(contacts: list));
      }
    });
  }

  FutureOr<void> _onEditContact(
      EditContact event, Emitter<SosContactsState> emit) async {
    List<SosGroupModel> contacts = state.contacts;
    final index = contacts.indexOf(event.oldContact);

    if (index != -1) {
      contacts[index] = event.newContact;
      emit(state.copyWith(contacts: contacts));
      print('Contact edited: $event.oldContact -> $event.newContact');
    }
  }

  loadContacts() {}
}
