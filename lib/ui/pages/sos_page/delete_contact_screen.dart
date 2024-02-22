import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/bloc/sos_contacts_bloc/sos_contacts_bloc.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteContactsPage extends StatefulWidget {
  const DeleteContactsPage({Key? key}) : super(key: key);

  @override
  State<DeleteContactsPage> createState() => _DeleteContactsPageState();
}

class _DeleteContactsPageState extends State<DeleteContactsPage> {
  List<SosContactModel> selectedContacts = [];
  bool isButtonEnable = false;
  SosContactsBloc get _sosContactsBloc {
    return BlocProvider.of<SosContactsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Видалення контактів'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ListView.builder(
                itemCount: _sosContactsBloc.contacts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 29),
                itemBuilder: (context, index) {
                  SosContactModel contactModel =
                      _sosContactsBloc.contacts[index];
                  return ContainerButtonWithCheckbox(
                      text: contactModel.name,
                      isSelected: selectedContacts.contains(
                        contactModel,
                      ),
                      onChanged: (value) {
                        handleCheckboxChange(
                          value,
                          contactModel,
                        );
                      });
                },
              ),
            ),
            SliverFillRemaining(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          red900.withOpacity(isButtonEnable ? 1 : 0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      _sosContactsBloc.add(
                        DeleteContact(contacts: selectedContacts),
                      );
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/sos", (route) => false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 44, vertical: 10),
                      child: Text(
                        'Видалити',
                        style: TextStyle(
                          color: primary50,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleCheckboxChange(bool? value, SosContactModel contact) {
    setState(() {
      if (value == true) {
        selectedContacts.add(contact);
      } else {
        selectedContacts.remove(contact);
      }
      isButtonEnable = selectedContacts.isNotEmpty;
    });
  }

  void _deleteSelectedContacts() {
    selectedContacts.clear();
    Navigator.of(context).pop();
  }
}

class ContainerButtonWithCheckbox extends StatelessWidget {
  final String text;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged;

  const ContainerButtonWithCheckbox({
    Key? key,
    required this.text,
    required this.isSelected,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: darkNeutral600,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: onChanged,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
