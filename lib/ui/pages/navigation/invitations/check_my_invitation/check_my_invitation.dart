import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/navigation/invitations/check_my_invitation/components/invitation_for_me.dart';
import 'package:chance_app/ui/pages/navigation/invitations/check_my_invitation/components/invitation_from_me.dart';
import 'package:chance_app/ux/bloc/navigation_bloc/invitation_bloc/invitation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckMyInvitation extends StatefulWidget {
  const CheckMyInvitation({super.key});

  @override
  State<CheckMyInvitation> createState() => _CheckMyInvitationState();
}

class _CheckMyInvitationState extends State<CheckMyInvitation> {
  PageController pageController = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    BlocProvider.of<InvitationBloc>(context).add(LoadInvitationsForMe());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: beigeBG,
      appBar: AppBar(centerTitle: true, title: const Text("Запрошення")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PageView(
          controller: pageController,
          onPageChanged: (page) {
            if (page == 0) {
              BlocProvider.of<InvitationBloc>(context)
                  .add(LoadInvitationsForMe());
            } else {
              BlocProvider.of<InvitationBloc>(context)
                  .add(LoadInvitationsFromMe());
            }
          },
          children: const [InvitationForMe(), InvitationFromMe()],
        ),
      ),
    );
  }
}
