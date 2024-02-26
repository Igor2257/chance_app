import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/labeled_text_field.dart';
import 'package:flutter/material.dart';

class AddGroupScreen extends StatefulWidget {
  const AddGroupScreen({Key? key}) : super(key: key);

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  final TextEditingController groupNameController = TextEditingController();
  final List<ContactItem> contacts = [ContactItem()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Створити групу',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 25,
          left: 16,
          right: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LabeledTextField(
                controller: groupNameController,
                label: "Введіть назву групи",
                hintText: "Сім'я",
                isPhone: false,
                onChanged: (value) {},
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  for (int index = 0; index < contacts.length; index++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Контакт ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        LabeledTextField(
                          controller: TextEditingController(),
                          label: "ім'я",
                          hintText: "ім'я",
                          isPhone: false,
                          onChanged: (value) {},
                        ),
                        LabeledTextField(
                          controller: TextEditingController(),
                          label: 'Телефон',
                          hintText: '+380',
                          isPhone: true,
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        contacts.add(ContactItem());
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add),
                        const SizedBox(width: 8),
                        Text(
                          'Додати контакт',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: primary800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/sos", (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary1000,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Зберегти групу',
                          style: TextStyle(
                            color: primary50,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactItem {}
