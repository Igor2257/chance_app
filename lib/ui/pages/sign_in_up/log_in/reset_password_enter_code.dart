import 'dart:async';

import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/sign_in_up/log_in/reset_password_enter_new_password.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ResetPasswordEnterCode extends StatefulWidget {
  const ResetPasswordEnterCode({super.key, required this.email});

  final String email;

  @override
  State<ResetPasswordEnterCode> createState() => _ResetPasswordEnterCodeState();
}

class _ResetPasswordEnterCodeState extends State<ResetPasswordEnterCode> {
  TextEditingController textEditingController = TextEditingController();

  FocusNode focusNode = FocusNode();
  int secondsLeft = 60;
  late final Timer timer;

  @override
  void initState() {
    loadTimer();
    super.initState();
  }
  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    timer.cancel();
    super.dispose();
  }

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
            const SizedBox(
              height: 120,
              child: Text(
                "Ми відправили на вашу пошту електронний лист з верифікаційним посиланням — код з 4 символів. Перевірте пошту, і якщо не знайдете листа — теку «спам»",
                style: TextStyle(fontSize: 16, letterSpacing: 0.5),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: PinCodeTextField(
                focusNode: focusNode,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(4),
                  fieldHeight: size.width / 6,
                  fieldWidth: size.width / 6,
                  activeFillColor: primary800,
                  selectedColor: primary800,
                  inactiveColor: primary800,
                  disabledColor: primary800,
                ),
                cursorColor: primary800,
                controller: textEditingController,
                appContext: context,
                length: 4,
                onSaved: (value)async {
                  String code =
                      textEditingController.text;
                  if(code.length==4) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => ResetPasswordEnterNewPassword(
                                email: widget.email, code: code)),
                            (route) => true);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Text(
                "Введіть код",
                style: TextStyle(color: primaryText, fontSize: 14),
              ),
            ),
            const Spacer(),
            const Spacer(),
            RoundedButton(
                onPress: () async {
                  String code =
                      textEditingController.text;
                       if(code.length==4) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordEnterNewPassword(
                              email: widget.email, code: code)),
                      (route) => true);
                  }
                },
                color: primary1000,
                child: Text(
                  "Підтвердити",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: primary50),
                )),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 40,
                    child: Text(
                      "Не отримали?   ${secondsLeft > 0 ? "Відправити знову: $secondsLeft сек." : ""}",
                      style: TextStyle(color: primaryText, fontSize: 14),
                    )),
                SizedBox(
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        if (!(secondsLeft > 0)) {
                          Repository().resendCode(widget.email);
                          //Repository().resendCode("vbifko4@gmail.com");
                          loadTimer();
                        }
                      },
                      child: Text(
                        secondsLeft > 0 ? "" : "Відправити повторно",
                        style: TextStyle(
                            color: secondsLeft > 0 ? primaryText : primary500,
                            fontSize: 16),
                      ),
                    )),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  loadTimer() async {
    secondsLeft = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      secondsLeft--;
      if (secondsLeft < 1) {
        timer.cancel();
      }
      setState(() {});
    });
  }
}
