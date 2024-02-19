import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/sign_in_up/log_in/reset_password_enter_code.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController editingController = TextEditingController();

  FocusNode focusNode = FocusNode();
  bool isError = false;
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Відновити пароль"),
      ),
      backgroundColor: beigeBG,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Введіть електронну пошту*",
                style: TextStyle(
                    fontSize: 14, color: isError ? red900 : primaryText),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: isError ? red900 : beige300),
                  borderRadius: BorderRadius.circular(16)),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    fontSize: 16, color: isError ? red900 : primaryText),
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  validate();
                  focusNode.unfocus();
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                focusNode: focusNode,
                controller: editingController,
              ),
            ),
            if (errorText.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  errorText,
                  style: TextStyle(fontSize: 14, color: red900),
                ),
              ),
            const Spacer(),
            const Spacer(),
            RoundedButton(
              color: primary1000,
              child: Text(
                "Підтвердити",
                style: TextStyle(fontSize: 16, color: primary50),
              ),
              onPress: () async {
                validate();
                if (!isError) {
                  await Repository().forgotPassword(editingController.text);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: beige100,
                          title: Center(
                            child: Text(
                              "Лист був відправлений",
                              style:
                                  TextStyle(color: primaryText, fontSize: 24),
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Перевірте свою пошту ${editingController.text},щоб отримати подальші інструкції звідновлення паролю",
                                style:
                                    TextStyle(color: primaryText, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                children: [
                                  const Spacer(),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ResetPasswordEnterCode(
                                                        email: editingController
                                                            .text)),
                                            (route) => true);
                                      },
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                            color: primary700, fontSize: 22),
                                      )),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Ми відправимо вам на email лист з інструкціями по відновленню паролю.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: primary700,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  decorationColor: primary700),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void validate() {
    if (editingController.text.trim().isEmpty) {
      errorText = 'Невірний формат електронної пошти';
      isError = true;
    } else {
      if (!RegExp(r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b',
              caseSensitive: false)
          .hasMatch(editingController.text)) {
        errorText = 'Невірний формат електронної пошти';
        isError = true;
      } else {
        errorText = "";
        isError = false;
      }
    }

    setState(() {});
  }
}
