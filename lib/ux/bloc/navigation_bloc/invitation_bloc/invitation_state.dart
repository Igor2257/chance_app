part of 'invitation_bloc.dart';

@immutable
class InvitationState {
  final List<InvitationModel> invitationsForMe;
  final List<InvitationModel> invitationsFromMe;

  final String? errorInvitationsForMe, errorInvitationsFromMe;
  final int page;
  final bool isLoading;

  const InvitationState({
    this.invitationsForMe = const [],
    this.invitationsFromMe = const [],
    this.errorInvitationsForMe,
    this.errorInvitationsFromMe,
    this.page = 0,
    this.isLoading = false,
  });

  InvitationState copyWith({
    List<InvitationModel>? invitationsForMe,
    List<InvitationModel>? invitationsFromMe,
    String? errorInvitationsForMe,
    String? errorInvitationsFromMe,
    int? page,
    bool? isLoading,
  }) {
    return InvitationState(
      errorInvitationsForMe:
          errorInvitationsForMe ?? this.errorInvitationsForMe,
      errorInvitationsFromMe:
          errorInvitationsFromMe ?? this.errorInvitationsFromMe,
      page: page ?? this.page,
      invitationsForMe: invitationsForMe ?? this.invitationsForMe,
      invitationsFromMe: invitationsFromMe ?? this.invitationsFromMe,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
