import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ui/pages/reminders_page/components/labeled_text_field.dart';
import 'package:chance_app/ux/bloc/sos_contacts_bloc/sos_contacts_bloc.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditGroupScreenSos extends StatefulWidget {
  final SosGroupModel groupModel;

  const EditGroupScreenSos({super.key, required this.groupModel});

  @override
  State<EditGroupScreenSos> createState() => _EditGroupScreenSosState();
}

class _EditGroupScreenSosState extends State<EditGroupScreenSos> {
  late TextEditingController groupNameController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late List<ContactItem> contacts;

  SosContactsBloc get _sosContactsBloc {
    return BlocProvider.of<SosContactsBloc>(context);
  }

  @override
  void initState() {
    super.initState();
    groupNameController = TextEditingController(text: widget.groupModel.name);
    contacts = widget.groupModel.contacts.map((contact) {
      return ContactItem(
        name: contact.name,
        phone: contact.phone,
      );
    }).toList();

    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.instance.translate("editGroup"),
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
                        InkWell(
                          onTap: () {
                            setState(() {
                              contacts.removeAt(index);
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.remove),
                              const SizedBox(width: 8),
                              Text(
                                AppLocalizations.instance
                                    .translate("deleteContact"),
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
                      ],
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
                          saveChanges();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary1000,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.instance.translate("saveChanges"),
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

  void saveChanges() {
    List<SosContactModel> updatedContacts = [];

    for (int index = 0; index < contacts.length; index++) {
      var contact = contacts[index];
      updatedContacts.add(
        SosContactModel(
          name: contact.nameController.text,
          phone: contact.phoneController.text,
          id: widget.groupModel.contacts[0].id,
        ),
      );
    }

    SosGroupModel updatedGroup = SosGroupModel(
      id: widget.groupModel.id,
      name: groupNameController.text,
      contacts: updatedContacts,
    );

    _sosContactsBloc.add(
      // DeleteContact(
      // ids: [updatedContacts[0].id])
      EditContact(
        contactModel: updatedGroup,
      ),
    );

    Navigator.of(context).pop();
  }
}

class ContactItem {
  final TextEditingController nameController;
  final TextEditingController phoneController;

  ContactItem({String? name, String? phone})
      : nameController = TextEditingController(text: name),
        phoneController = TextEditingController(text: phone);
}
