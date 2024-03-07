import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chance_app/ux/enum/invitation_status.dart';
import 'package:chance_app/ux/model/invitation_model.dart';
import 'package:chance_app/ux/repository/invitation_repository.dart';
import 'package:chance_app/ux/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'invitation_event.dart';

part 'invitation_state.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  InvitationBloc() : super(const InvitationState()) {
    on<LoadInvitationsForMe>(_onLoadInvitationsForMe);
    on<LoadInvitationsFromMe>(_onLoadInvitationsFromMe);
  }

  FutureOr<void> _onLoadInvitationsForMe(
      LoadInvitationsForMe event, Emitter<InvitationState> emit) async {
    emit(state.copyWith(isLoading: true, page: 0));
    String error = "";
    List<InvitationModel> list = [];
    await InvitationRepository().getInvitationForMe().then((value) {
      if (value is List<InvitationModel>) {
        list = value;
      } else {
        error = value;
      }
    });
    list.add(InvitationModel(
      id: "0",
      email: "email@mail.com",
      sentDate: DateTime.now(),
      fromUserId: "cdscds",
      toUserId: "dsccdscds",
      invitationStatus: InvitationStatus.pending,
      fromUserName: "cddcsdcdsccdscdsd",
    ));
    list.add(InvitationModel(
      id: "1",
      email: "email1@mail.com",
      sentDate: DateTime.now(),
      fromUserId: "dcsdcscdscs",
      toUserId: "qwqssqsq",
      invitationStatus: InvitationStatus.pending,
      fromUserName: "jkjkhhmh",
    ));
    emit(state.copyWith(
        isLoading: false,
        errorInvitationsForMe: error,
        invitationsForMe: list));
  }

  FutureOr<void> _onLoadInvitationsFromMe(
      LoadInvitationsFromMe event, Emitter<InvitationState> emit) async {
    emit(state.copyWith(isLoading: true, page: 1));
    String error = "";
    List<InvitationModel> list = [];
    await InvitationRepository().getInvitationFromMe().then((value) {
      if (value is List<InvitationModel>) {
        list = value;
      } else {
        error = value;
      }
    });
    list.add(InvitationModel(
      id: "0",
      email: "email@mail.com",
      sentDate: DateTime.now(),
      fromUserId: "cdscds",
      toUserId: "dsccdscds",
      invitationStatus: InvitationStatus.pending,
      fromUserName: "cddcsdcdsccdscdsd",
    ));
    list.add(InvitationModel(
      id: "1",
      email: "email1@mail.com",
      sentDate: DateTime.now(),
      fromUserId: "dcsdcscdscs",
      toUserId: "qwqssqsq",
      invitationStatus: InvitationStatus.pending,
      fromUserName: "jkjkhhmh",
    ));
    emit(state.copyWith(
        isLoading: false,
        errorInvitationsFromMe: error,
        invitationsFromMe: list));
  }
}