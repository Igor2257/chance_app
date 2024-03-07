import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/navigation/invitations/check_my_invitation/components/invitation_for_me.dart';
import 'package:chance_app/ui/pages/navigation/invitations/check_my_invitation/components/invitation_from_me.dart';
import 'package:chance_app/ux/bloc/navigation_bloc/invitation_bloc/invitation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InvitationParts { forMe, fromMe }

class CheckMyInvitation extends StatefulWidget {
  const CheckMyInvitation({super.key});

  @override
  State<CheckMyInvitation> createState() => _CheckMyInvitationState();
}

class _CheckMyInvitationState extends State<CheckMyInvitation> {
  final tabs = {
    InvitationParts.forMe: "Для мене",
    InvitationParts.fromMe: "Від мене",
  };
  var _selectedTab = InvitationParts.forMe;

  @override
  void initState() {
    BlocProvider.of<InvitationBloc>(context).add(LoadInvitationsForMe());
    BlocProvider.of<InvitationBloc>(context).add(LoadInvitationsFromMe());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: beigeBG,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Запрошення",
            style: TextStyle(
              fontSize: 22,
              color: primaryText,
            ),
          )),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: beige300),
                ),
                position: DecorationPosition.foreground,
                child: CupertinoSlidingSegmentedControl(
                  backgroundColor: beige100,
                  thumbColor: darkNeutral600,
                  groupValue: _selectedTab,
                  onValueChanged: (value) => setState(() {
                    _selectedTab = value!;
                  }),
                  children: {
                    for (final tab in tabs.keys)
                      tab: SizedBox(
                        width: size.width / 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          child: Text(
                            tabs[tab]!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: (_selectedTab == tab)
                                  ? Colors.white
                                  : const Color(0xff57524C),
                            ),
                          ),
                        ),
                      )
                  },
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 125),
                  child: _selectedTab == InvitationParts.forMe
                      ? const InvitationForMe()
                      : const InvitationFromMe(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}