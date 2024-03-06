import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/navigation/invitations/check_my_invitation/components/invitation_from_me_timer.dart';
import 'package:chance_app/ux/bloc/navigation_bloc/invitation_bloc/invitation_bloc.dart';
import 'package:chance_app/ux/enum/invitation_status.dart';
import 'package:chance_app/ux/model/invitation_model.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InvitationFromMe extends StatelessWidget {
  const InvitationFromMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: beigeTransparent),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(child: Text("Запрошення від мене",maxLines: 3,)),
                  InvitationFromMeTimer(),
                ],
              ),
            ),
            const Divider(),
            Expanded(child: BlocBuilder<InvitationBloc, InvitationState>(
                builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              if (state.errorInvitationsFromMe == "noInternet") {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off),
                    Text(
                      "Немає доступу до інтернету",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: primaryText),
                    ),
                  ],
                );
              }
              List<InvitationModel> invitationsFromMe = state.invitationsFromMe;
              if (invitationsFromMe.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/box_open.svg"),
                    Text(
                      "Ви нікого не запросили",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: primaryText),
                    ),
                  ],
                );
              }
              return Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                    itemCount: invitationsFromMe.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, position) {
                      InvitationModel invitationFromMe =
                          invitationsFromMe[position];
                      return Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black87))),
                          child: Row(
                            children: [
                              Expanded(child: Wrap(children: [
                                Text(
                                  invitationFromMe.email,
                                  style: TextStyle(
                                      fontSize: 16, color: primaryText),
                                  maxLines: 1,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  invitationFromMe.invitationStatus
                                      .toLocalizedString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: invitationFromMe.invitationStatus ==
                                          InvitationStatus.pending
                                          ? darkNeutral600
                                          : invitationFromMe.invitationStatus ==
                                          InvitationStatus.accepted
                                          ? green
                                          : red900),
                                ),
                              ])),
                              IconButton(
                                  onPressed: ()async {
                                    await Repository().removeInvitation(invitationFromMe.id).then((value) {
                                      if(value==null){
                                        BlocProvider.of<InvitationBloc>(context)
                                            .add(LoadInvitationsFromMe());
                                      }else{
                                        Fluttertoast.showToast(msg: value);
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          ));
                    }),
              );
            })),
          ],
        ));
  }
}
