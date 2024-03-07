import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/labeled_text_field.dart';
import 'package:chance_app/ux/bloc/sos_contacts_bloc/sos_contacts_bloc.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddGroupScreen extends StatefulWidget {
  bool isGroup;
  AddGroupScreen({this.isGroup = false, Key? key}) : super(key: key);

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  final TextEditingController groupNameController = TextEditingController();
  final List<ContactItem> contacts = [ContactItem()];
  late bool isGroup;
  late List<String> groupNames;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController groupController = TextEditingController();

  SosContactsBloc get _sosContactsBloc {
    return BlocProvider.of<SosContactsBloc>(context);
  }

  @override
  void initState() {
    isGroup = widget.isGroup;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    isGroup = ModalRoute.of(context)!.settings.arguments as bool;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isGroup ? 'Створити групу' : "Додати контакт",
          style: const TextStyle(
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
              Visibility(
                visible: isGroup,
                child: LabeledTextField(
                  controller: groupNameController,
                  label: "Введіть назву групи",
                  hintText: "Сім'я",
                  isPhone: false,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  for (int index = 0; index < contacts.length; index++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isGroup ? 'Контакт ${index + 1}' : "",
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
                          controller: nameController,
                          label: "ім'я",
                          hintText: "ім'я",
                          isPhone: false,
                          onChanged: (value) {},
                        ),
                        LabeledTextField(
                          controller: phoneController,
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
                  Visibility(
                    visible: isGroup,
                    child: InkWell(
                      onTap: () {
                        setState(
                          () {
                            contacts.add(
                              ContactItem(),
                            );
                          },
                        );
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
                        onPressed: isGroup
                            ? () {
                                if (nameController.text.length >= 3 &&
                                    phoneController.text.startsWith('+380') &&
                                    phoneController.text.length == 13) {
                                  _sosContactsBloc.add(
                                    SaveContact(contacts: [
                                      SosContactModel(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        group: groupController.text,
                                      ),
                                    ]),
                                  );
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      "/sos", (route) => false);

                                  nameController.clear();
                                  phoneController.clear();
                                  groupController.clear();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Перевірте коректність даних'),
                                    ),
                                  );
                                }
                              }
                            : () {
                                if (nameController.text.length >= 3 &&
                                    phoneController.text.startsWith('+380') &&
                                    phoneController.text.length == 13) {
                                  _sosContactsBloc.add(
                                    SaveContact(contacts: [
                                      SosContactModel(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      ),
                                    ]),
                                  );
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      "/sos", (route) => false);
                                  // Очистка полей
                                  nameController.clear();
                                  phoneController.clear();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Перевірте коректність даних'),
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary1000,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          isGroup ? 'Зберегти групу' : "Додати контакт",
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
