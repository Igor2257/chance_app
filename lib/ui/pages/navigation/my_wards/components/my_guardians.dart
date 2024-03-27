import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ui/pages/navigation/my_wards/components/my_guardians_timer.dart';
import 'package:chance_app/ux/bloc/navigation_bloc/invitation_bloc/invitation_bloc.dart';
import 'package:chance_app/ux/model/invitation_model.dart';
import 'package:chance_app/ux/repository/invitation_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyGuardians extends StatefulWidget {
  const MyGuardians({super.key});

  @override
  State<MyGuardians> createState() => _MyGuardiansState();
}

class _MyGuardiansState extends State<MyGuardians> {
  bool isLoading = false;
@override
  void initState() {
  BlocProvider.of<InvitationBloc>(context).add(LoadMyGuardians());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: MyGuardiansTimer(),
        ),
        Expanded(
          child: BlocBuilder<InvitationBloc, InvitationState>(
              builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state.errorMyGuardians == "noInternet") {
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
            List<InvitationModel> myGuardians = state.myGuardians;
            if (myGuardians.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/box_open.svg"),
                  Text(
                    AppLocalizations.instance.translate("youHaveNoGuardians"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, color: primaryText),
                  ),
                ],
              ));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: myGuardians.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, position) {
                InvitationModel invitationForMe = myGuardians[position];
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
                                  invitationForMe.fromUserName,
                                  style: const TextStyle(
                                      fontSize: 16, color: primaryText),
                                  maxLines: 1,
                                ),
                                Text(
                                  invitationForMe.fromUserEmail,
                                  style: const TextStyle(
                                      fontSize: 16, color: primaryText),
                                  maxLines: 1,
                                ),
                              ]),
                        ),
                        IconButton(
                            onPressed: () async {
                              if (!isLoading) {
                                setState(() {
                                  isLoading = true;
                                });
                                await InvitationRepository()
                                    .deleteWard(invitationForMe.id)
                                    .then((value) {
                                  if (value == null) {
                                    BlocProvider.of<InvitationBloc>(context)
                                        .add(LoadMyGuardians());
                                  } else {
                                    Fluttertoast.showToast(msg: value);
                                  }
                                  isLoading = false;
                                  if (mounted) {
                                    setState(() {});
                                  }
                                });
                              }
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
        ),
      ],
    );
  }
}