import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ux/bloc/navigation_bloc/invitation_bloc/invitation_bloc.dart';
import 'package:chance_app/ux/model/invitation_model.dart';
import 'package:chance_app/ux/repository/invitation_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyWards extends StatefulWidget {
  const MyWards({super.key});

  @override
  State<MyWards> createState() => _MyWardsState();
}

class _MyWardsState extends State<MyWards> {
  @override
  void initState() {
    BlocProvider.of<InvitationBloc>(context).add(LoadMyWards());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: beigeBG,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(AppLocalizations.instance.translate("myWards")),
      ),
      body: BlocBuilder<InvitationBloc, InvitationState>(
          builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state.errorInvitationsForMe == "noInternet") {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off),
              Text(
                AppLocalizations.instance.translate("noInternetConnection"),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: primaryText),
              ),
            ],
          ));
        }
        List<InvitationModel> invitationsForMe = state.invitationsForMe;
        if (invitationsForMe.isEmpty) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/box_open.svg"),
              Text(
                AppLocalizations.instance.translate("youHaveNoInvitations"),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: primaryText),
              ),
            ],
          ));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: invitationsForMe.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, position) {
            InvitationModel invitationForMe = invitationsForMe[position];
            return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primary50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              invitationForMe.toUserName,
                              style: const TextStyle(
                                  fontSize: 16, color: primaryText),
                              maxLines: 1,
                            ),
                            Text(
                              invitationForMe.toUserEmail,
                              style: const TextStyle(
                                  fontSize: 16, color: primaryText),
                              maxLines: 1,
                            ),
                          ]),
                    ),
                    IconButton(
                        onPressed: () async {
                          await InvitationRepository()
                              .deleteWard(invitationForMe.id)
                              .then((value) {
                            if (value == null) {
                              BlocProvider.of<InvitationBloc>(context)
                                  .add(LoadInvitationsForMe());
                            } else {
                              Fluttertoast.showToast(msg: value);
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: red800,
                        )),
                  ],
                ));
          },
        );
      }),
    );
  }
}
