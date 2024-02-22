import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/labeled_text_field.dart';
import 'package:flutter/material.dart';

class AddGroupScreen extends StatelessWidget {
  const AddGroupScreen({Key? key}) : super(key: key);

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LabeledTextField(
              controller: TextEditingController(),
              label: "Введіть назву групи",
              hintText: "Сім'я",
              isPhone: false,
            ),
            const SizedBox(height: 8),
            const ContactList(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: primary1000,
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
          ],
        ),
      ),
    );
  }
}

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final List<ContactItem> contacts = [];

  void addContact() {
    contacts.add(ContactItem());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < contacts.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Контакт ${i + 1}',
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
              ),
              LabeledTextField(
                controller: TextEditingController(),
                label: 'Телефон',
                hintText: '+380',
                isPhone: true,
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
        InkWell(
          onTap: addContact,
          child: Row(
            children: [
              const Icon(Icons.add),
              const SizedBox(width: 8),
              Text(
                'Додати контакт',
                style: TextStyle(
                  // fontFamily: ,
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
      ],
    );
  }
}

class ContactItem {}
