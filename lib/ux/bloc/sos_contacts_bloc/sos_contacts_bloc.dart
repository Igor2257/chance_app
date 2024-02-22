import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:flutter/material.dart';

part 'sos_contacts_state.dart';
part 'sos_contacts_event.dart';

class SosContactsBloc extends Bloc<SosContactsEvent, SosContactsState> {
  List<SosContactModel> contacts = [
    SosContactModel(name: 'Maman', phone: '+380951234567'),
    SosContactModel(name: 'Testss', phone: '+380954444444'),
  ];
  SosContactsBloc() : super(SosContactsState()) {
    on<SaveContact>(_onSaveContact);
    on<DeleteContact>(_onDeleteContact);
  }

  FutureOr<void> _onSaveContact(
      SaveContact event, Emitter<SosContactsState> emit) {
    contacts.add(event.contactModel);
    emit(state.copyWith(contacts: contacts));
  }

  FutureOr<void> _onDeleteContact(
      DeleteContact event, Emitter<SosContactsState> emit) {
    for (var element in event.contacts) {
      contacts.remove(element);
    }

    emit(state.copyWith(contacts: contacts));
  }
}
