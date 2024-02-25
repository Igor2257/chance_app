import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/menu/components/input_my_info_layout.dart';
import 'package:chance_app/ux/model/me_user.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';

class MyInformation extends StatefulWidget {
  const MyInformation({super.key});

  @override
  State<MyInformation> createState() => _MyInformationState();
}

class _MyInformationState extends State<MyInformation> {
  TextEditingController firstNameTextEditingController =
          TextEditingController(),
      lastNameTextEditingController = TextEditingController(),
      phoneTextEditingController = TextEditingController(),
      emailTextEditingController = TextEditingController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Особиста інформація"),
      ),
      backgroundColor: beigeBG,
      body: Column(
        children: [
          InputMyInfoLayout(
              title: "Імʼя*",
              textEditingController: firstNameTextEditingController),
          InputMyInfoLayout(
              title: "Прізвище*",
              textEditingController: lastNameTextEditingController),
          InputMyInfoLayout(
              title: "Номер телефону",
              textEditingController: phoneTextEditingController),
          InputMyInfoLayout(
              title: "Електронна пошта",
              textEditingController: emailTextEditingController),
        ],
      ),
    );
  }

  void loadData() async {
    MeUser user = Repository().user!;
    firstNameTextEditingController.text = user.name;
    lastNameTextEditingController.text = user.lastName;
    phoneTextEditingController.text = user.phone;
    emailTextEditingController.text = user.email;
  }
}
