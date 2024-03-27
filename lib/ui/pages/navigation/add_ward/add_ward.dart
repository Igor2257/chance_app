import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ui/pages/navigation/add_ward/components/input_ward_layout.dart';
import 'package:chance_app/ux/bloc/navigation_bloc/add_ward/add_ward_bloc.dart';
import 'package:chance_app/ux/hive_crud.dart';
import 'package:chance_app/ux/model/settings.dart';
import 'package:chance_app/ux/repository/invitation_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddWard extends StatefulWidget {
  const AddWard({super.key});

  @override
  State<AddWard> createState() => _AddWardState();
}

class _AddWardState extends State<AddWard> {
  final TextEditingController nameTextEditingController =
          TextEditingController(),
      emailTextEditingController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode(), emailFocusNode = FocusNode();
  bool isLoading = false;

  @override
  void initState() {
    BlocProvider.of<AddWardBloc>(context).add(ClearData());
    super.initState();
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
    nameTextEditingController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AddWardBloc, AddWardState>(builder: (context, state) {
      return Stack(children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
            title: Text(AppLocalizations.instance.translate("addWard")),
            leading: BackButton(
              onPressed: () {
                BlocProvider.of<AddWardBloc>(context).add(ClearData());
                Navigator.of(context).pop(false);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: IgnorePointer(
              ignoring: isLoading,
              child: Column(
                children: [
                  InputWardLayout(
                    title: AppLocalizations.instance.translate("enterName"),
                    focusNode: nameFocusNode,
                    textInputAction: TextInputAction.next,
                    inputWardLayouts: InputWardLayouts.name,
                    textInputType: TextInputType.text,
                    textEditingController: nameTextEditingController,
                    focusOtherField: () {
                      nameFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(emailFocusNode);
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  InputWardLayout(
                    title:
                        AppLocalizations.instance.translate("enterYourEmail"),
                    focusNode: emailFocusNode,
                    textInputAction: TextInputAction.done,
                    inputWardLayouts: InputWardLayouts.email,
                    textInputType: TextInputType.emailAddress,
                    textEditingController: emailTextEditingController,
                    focusOtherField: () {
                      emailFocusNode.unfocus();
                    },
                  ),
                  const Spacer(),
                  RoundedButton(
                      onPress: () async {
                        nameFocusNode.unfocus();
                        emailFocusNode.unfocus();

                        setState(() {
                          isLoading = true;
                        });
                        bool isError = state.errorEmail == null;
                        if (!isError) {
                          isError = state.errorName == null;
                        }
                        if (!isError) {
                          isError = state.errorEmail!.trim().isNotEmpty;
                        }
                        if (!isError) {
                          isError = state.errorName!.trim().isNotEmpty;
                        }
                        if (!isError) {
                          await InvitationRepository()
                              .sendConfirmToWard(nameTextEditingController.text,
                                  emailTextEditingController.text)
                              .then((value) async {
                            if (value == null || value == "null") {
                              final crud = HiveCRUD();
                              Settings settings = crud.setting;
                              settings = settings.copyWith(
                                  isAppShouldSentLocation: true);
                              await crud.updateSettings(settings).then((value) {
                                Navigator.of(context).pop(true);
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: value, toastLength: Toast.LENGTH_LONG);
                            }
                          });
                          isLoading = false;
                          if (mounted) {
                            setState(() {});
                          }
                        }
                      },
                      color: primary1000,
                      child: Text(
                        AppLocalizations.instance.translate("add"),
                        style: const TextStyle(
                            fontSize: 16,
                            color: primary50,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            ),
          ),
        ),
        if (isLoading)
          Container(
            decoration: const BoxDecoration(color: Colors.black26),
            height: size.height,
            width: size.width,
            child: const Center(
              child: CupertinoActivityIndicator(
                color: primary500,
                radius: 50,
              ),
            ),
          )
      ]);
    });
  }
}
