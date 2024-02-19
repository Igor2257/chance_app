import 'dart:async';

import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/bloc/registration_bloc/registration_bloc.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterCodeForRegister extends StatefulWidget {
  const EnterCodeForRegister({super.key});

  @override
  State<EnterCodeForRegister> createState() => _EnterCodeForRegisterState();
}

class _EnterCodeForRegisterState extends State<EnterCodeForRegister> {
  TextEditingController firstTextEditingController = TextEditingController(),
      secondTextEditingController = TextEditingController(),
      thirdTextEditingController = TextEditingController(),
      fourthTextEditingController = TextEditingController();

  FocusNode firstFocusNode = FocusNode(),
      secondFocusNode = FocusNode(),
      thirdFocusNode = FocusNode(),
      fourthFocusNode = FocusNode();
  int secondsLeft = 60;
  late final Timer timer;

  @override
  void initState() {
    loadTimer();
    super.initState();
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: const Text("Реєстрація"),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(firstFocusNode);
                      },
                      child: Container(
                          width: size.width / 6,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: primary800)),
                          child: Center(
                            child: SizedBox(
                              width: size.width / 20,
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: firstTextEditingController,
                                focusNode: firstFocusNode,
                                onChanged: (value) {
                                  firstFocusNode.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(secondFocusNode);
                                  if (value.length > 1) {
                                    secondTextEditingController.text = value[1];
                                  } else if (value.isEmpty) {
                                    firstFocusNode.unfocus();
                                  }
                                },
                                onSubmitted: (v) {
                                  firstFocusNode.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(secondFocusNode);
                                },
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: primary800))),
                              ),
                            ),
                          )),
                    ),
                    GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(secondFocusNode);
                        },
                        child: Container(
                            width: size.width / 6,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 14),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: primary800)),
                            child: Center(
                              child: SizedBox(
                                width: size.width / 20,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: secondTextEditingController,
                                  focusNode: secondFocusNode,
                                  onChanged: (value) {
                                    secondFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(thirdFocusNode);
                                    if (value.length > 1) {
                                      thirdTextEditingController.text =
                                          value[1];
                                    } else if (value.isEmpty) {
                                      secondFocusNode.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(firstFocusNode);
                                    }
                                  },
                                  onSubmitted: (v) {
                                    secondFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(thirdFocusNode);
                                  },
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: primary800))),
                                ),
                              ),
                            ))),
                    GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(thirdFocusNode);
                        },
                        child: Container(
                            width: size.width / 6,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 14),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: primary800)),
                            child: Center(
                              child: SizedBox(
                                width: size.width / 20,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: thirdTextEditingController,
                                  focusNode: thirdFocusNode,
                                  onChanged: (value) {
                                    thirdFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(fourthFocusNode);
                                    if (value.length > 1) {
                                      fourthTextEditingController.text =
                                          value[1];
                                    } else if (value.isEmpty) {
                                      thirdFocusNode.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(secondFocusNode);
                                    }
                                  },
                                  onSubmitted: (v) {
                                    thirdFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(fourthFocusNode);
                                  },
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: primary800))),
                                ),
                              ),
                            ))),
                    GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(fourthFocusNode);
                        },
                        child: Container(
                            width: size.width / 6,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 14),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: primary800)),
                            child: Center(
                              child: SizedBox(
                                width: size.width / 20,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: fourthTextEditingController,
                                  focusNode: fourthFocusNode,
                                  onChanged: (value) {
                                    fourthFocusNode.unfocus();
                                    if (value.length > 1) {
                                      fourthTextEditingController.text =
                                          value[0];
                                    } else if (value.isEmpty) {
                                      fourthFocusNode.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(thirdFocusNode);
                                    }
                                  },
                                  onSubmitted: (v) {
                                    fourthFocusNode.unfocus();
                                  },
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: primary800))),
                                ),
                              ),
                            ))),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
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
                        "${firstTextEditingController.text}${secondTextEditingController.text}${thirdTextEditingController.text}${fourthTextEditingController.text}";
                    print(code);
                    await Repository()
                        .checkIsCodeValid(code, state.email)
                        .then((value) {
                      if (value) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/subscription_page", (route) => false);
                      }
                    });
                    //BlocProvider.of<RegistrationBloc>(context)
                    //    .add(IncreaseCurrentStep(context));
                  },
                  color: primary1000,
                  child: Text(
                    "Завершити",
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
                            //Repository().resendCode(state.email);
                            Repository().resendCode("vbifko4@gmail.com");
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
    });
  }

  loadTimer() async {
    secondsLeft = 60;
    timer=Timer.periodic(Duration(seconds: 1), (timer) {
      secondsLeft--;
      if (secondsLeft < 1) {
        timer.cancel();
      }
      setState(() {});
    });
  }
}
