import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/labeled_text_field.dart';
import 'package:chance_app/ux/bloc/sos_contacts_bloc/sos_contacts_bloc.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({Key? key}) : super(key: key);

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  SosContactsBloc get _sosContactsBloc {
    return BlocProvider.of<SosContactsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Створити контакт',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22,
            // fontFamily: ,
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
              controller: nameController,
              label: "Введіть ім'я",
              hintText: "ім'я",
              isPhone: false,
              onChanged: (value) {},
            ),
            LabeledTextField(
              controller: phoneController,
              label: "Введіть номер телефону",
              hintText: '+380',
              isPhone: true,
              onChanged: (value) {},
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  final nameTextField = LabeledTextFieldState.nameTextField;
                  final phoneTextField = LabeledTextFieldState.phoneTextField;

                  if (nameTextField != null && phoneTextField != null) {
                    if (nameTextField.validate() && phoneTextField.validate()) {
                      _sosContactsBloc.add(
                        SaveContact(contacts: [
                          SosContactModel(
                            name: nameController.text,
                            phone: phoneController.text,
                          ),
                        ]),
                      );
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/sos", (route) => false);
                      nameTextField.clear();
                      phoneTextField.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Перевірте коректність даних'),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary1000,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Зберегти контакт',
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
