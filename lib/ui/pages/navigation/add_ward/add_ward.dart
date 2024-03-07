import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/navigation/add_ward/components/input_ward_layout.dart';
import 'package:chance_app/ux/bloc/navigation_bloc/add_ward/add_ward_bloc.dart';
import 'package:chance_app/ux/repository/invitation_repository.dart';
import 'package:chance_app/ux/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddWardBloc, AddWardState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Додати підопічного"),
          leading: BackButton(
            onPressed: () {
              BlocProvider.of<AddWardBloc>(context).add(ClearData());
              Navigator.of(context).pop(false);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InputWardLayout(
                title: "Введіть ім’я",
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
                title: "Введіть електронну пошту",
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
                    if ((state.errorEmail == null && state.errorName == null) ||
                        ((state.errorEmail != null &&
                                state.errorEmail!.isEmpty) &&
                            (state.errorName != null &&
                                state.errorName!.isEmpty))) {
                      await InvitationRepository()
                          .sendConfirmToWard(emailTextEditingController.text)
                          .then((value) {
                        if (value == null) {
                          Navigator.of(context).pop(true);
                        }
                      });
                    }
                  },
                  color: primary1000,
                  child: Text(
                    "Надіслати код ",
                    style: TextStyle(
                        fontSize: 16,
                        color: primary50,
                        fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
