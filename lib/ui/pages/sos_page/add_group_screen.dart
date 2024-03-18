// import 'package:chance_app/ui/constans.dart';
// import 'package:chance_app/ui/l10n/app_localizations.dart';
// import 'package:chance_app/ui/pages/reminders_page/components/labeled_text_field.dart';
// import 'package:chance_app/ux/bloc/sos_contacts_bloc/sos_contacts_bloc.dart';
// import 'package:chance_app/ux/model/sos_contact_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AddGroupScreen extends StatefulWidget {
//   const AddGroupScreen({super.key});

//   @override
//   State<AddGroupScreen> createState() => _AddGroupScreenState();
// }

// class _AddGroupScreenState extends State<AddGroupScreen> {
//   SosContactsBloc get _sosContactsBloc {
//     return BlocProvider.of<SosContactsBloc>(context);
//   }

//   final TextEditingController groupNameController = TextEditingController();
//   final List<ContactItem> contacts = [ContactItem()];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           AppLocalizations.instance.translate("createAGroup"),
//           style: const TextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: 22,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(
//           top: 25,
//           left: 16,
//           right: 16,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               LabeledTextField(
//                 controller: groupNameController,
//                 label: AppLocalizations.instance.translate("enterGroupName"),
//                 hintText: AppLocalizations.instance.translate("family"),
//                 isPhone: false,
//                 onChanged: (value) {},
//               ),
//               const SizedBox(height: 8),
//               Column(
//                 children: [
//                   for (int index = 0; index < contacts.length; index++)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           AppLocalizations.instance
//                               .translate("contact ${index + 1}"),
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                             color: Colors.black,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         LabeledTextField(
//                           controller: TextEditingController(),
//                           label: AppLocalizations.instance.translate("name"),
//                           hintText: AppLocalizations.instance.translate("name"),
//                           isPhone: false,
//                           onChanged: (value) {},
//                         ),
//                         LabeledTextField(
//                           controller: TextEditingController(),
//                           label: AppLocalizations.instance.translate("phone"),
//                           hintText: '+380',
//                           isPhone: true,
//                           onChanged: (value) {},
//                         ),
//                         const SizedBox(
//                           height: 18,
//                         ),
//                       ],
//                     ),
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         contacts.add(ContactItem());
//                       });
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(Icons.add),
//                         const SizedBox(width: 8),
//                         Text(
//                           AppLocalizations.instance.translate("addContact"),
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: primary800,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 18),
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 48,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           List<SosContactModel> contactModels = [];

//                           // Пройти по каждому контакту и получить значения из соответствующих текстовых полей
//                           for (int index = 0;
//                               index < contacts.length;
//                               index++) {
//                             TextEditingController nameController =
//                                 TextEditingController();
//                             TextEditingController phoneController =
//                                 TextEditingController();

//                             // Получить значения из текстовых полей
//                             String name = nameController.text;
//                             String phone = phoneController.text;

//                             // Создать экземпляр SosContactModel и добавить его в список
//                             SosContactModel contactModel = SosContactModel(
//                               name: name,
//                               phone: phone,
//                               groupName: groupNameController.text,
//                             );

//                             contactModels.add(contactModel);
//                           }

//                           // Создать экземпляр SosGroupModel с полученными контактами и именем группы
//                           SosGroupModel sosGroupModel = SosGroupModel(
//                             name: groupNameController.text,
//                             contacts: contactModels,
//                           );

//                           // Передать sosGroupModel в ваш блок
//                           _sosContactsBloc.add(
//                             SaveContact(
//                                 contactModel: sosGroupModel, isGroup: true),
//                           );

//                           Navigator.of(context).pushNamedAndRemoveUntil(
//                               "/sos", (route) => false);
//                           // _sosContactsBloc.add(
//                           //   SaveContact(
//                           //     contactModel: const SosGroupModel(
//                           //         name: "groupNameController.text",
//                           //         contacts: [
//                           //           SosContactModel(
//                           //             name: "MyName",
//                           //             phone: "+380504564561",
//                           //             groupName: "groupName",
//                           //           )
//                           //         ]),
//                           //     isGroup: true,
//                           //   ),
//                           // );
//                           // Navigator.of(context).pushNamedAndRemoveUntil(
//                           //     "/sos", (route) => false);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: primary1000,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                         child: Text(
//                           AppLocalizations.instance.translate("saveTheGroup"),
//                           style: TextStyle(
//                             color: primary50,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ContactItem {}

import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ui/pages/reminders_page/components/labeled_text_field.dart';
import 'package:chance_app/ux/bloc/sos_contacts_bloc/sos_contacts_bloc.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddGroupScreen extends StatefulWidget {
  const AddGroupScreen({super.key});

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  SosContactsBloc get _sosContactsBloc {
    return BlocProvider.of<SosContactsBloc>(context);
  }

  final TextEditingController groupNameController = TextEditingController();
  final List<ContactItem> contacts = [];

  @override
  void initState() {
    super.initState();

    initContacts();
  }

  void initContacts() {
    contacts.add(ContactItem());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.instance.translate("createAGroup"),
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
              LabeledTextField(
                controller: groupNameController,
                label: AppLocalizations.instance.translate("enterGroupName"),
                hintText: AppLocalizations.instance.translate("family"),
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
                          AppLocalizations.instance
                              .translate("contact ${index + 1}"),
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
                          controller: contacts[index].nameController,
                          label: AppLocalizations.instance.translate("name"),
                          hintText: AppLocalizations.instance.translate("name"),
                          isPhone: false,
                          onChanged: (value) {},
                        ),
                        LabeledTextField(
                          controller: contacts[index].phoneController,
                          label: AppLocalizations.instance.translate("phone"),
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
                          AppLocalizations.instance.translate("addContact"),
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
                          List<SosContactModel> contactModels = [];

                          for (int index = 0;
                              index < contacts.length;
                              index++) {
                            String name = contacts[index].nameController.text;
                            String phone = contacts[index].phoneController.text;

                            SosContactModel contactModel = SosContactModel(
                              name: name,
                              phone: phone,
                              groupName: groupNameController.text,
                            );

                            contactModels.add(contactModel);
                          }

                          SosGroupModel sosGroupModel = SosGroupModel(
                            name: groupNameController.text,
                            contacts: contactModels,
                          );

                          _sosContactsBloc.add(
                            SaveContact(
                              contactModel: sosGroupModel,
                              isGroup: true,
                            ),
                          );

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
                          AppLocalizations.instance.translate("saveTheGroup"),
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

class ContactItem {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
}
