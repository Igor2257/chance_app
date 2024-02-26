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
  late bool isEdit;
  SosContactsBloc get _sosContactsBloc {
    return BlocProvider.of<SosContactsBloc>(context);
  }

  @override
  void didChangeDependencies() {
    isEdit = ModalRoute.of(context)!.settings.arguments as bool;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit == true ? 'Видалення контактів' : 'Змінити'),
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
                      contactModel: contactModel,
                      text: contactModel.name,
                      isSelected: selectedContacts.contains(
                        contactModel,
                      ),
                      isEdit: isEdit,
                      onChanged: (value) {
                        handleCheckboxChange(
                          value,
                          contactModel,
                        );
                      });
                },
              ),
            ),
            if (isEdit)
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
                        if (isButtonEnable) {
                          _sosContactsBloc.add(
                            DeleteContact(contacts: selectedContacts),
                          );
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/sos", (route) => false);
                        }
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
      if (value != false) {
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

class ContainerButtonWithCheckbox extends StatefulWidget {
  final String text;
  final bool isSelected;
  final bool isEdit;
  final ValueChanged<bool?>? onChanged;
  final SosContactModel contactModel;

  const ContainerButtonWithCheckbox({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.isEdit,
    required this.contactModel,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ContainerButtonWithCheckbox> createState() =>
      _ContainerButtonWithCheckboxState();
}

class _ContainerButtonWithCheckboxState
    extends State<ContainerButtonWithCheckbox> {
  Color containerColor = darkNeutral600;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isEdit == false) {
          Navigator.pushNamed(context, "/replace_contact_sos",
              arguments: widget.contactModel);
        }
      },
      child: Container(
        width: double.infinity,
        height: 72,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: widget.isEdit
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.isEdit,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Checkbox(
                  activeColor: darkNeutral800,
                  checkColor: primary50,
                  value: widget.isSelected,
                  onChanged: (value) {
                    setState(() {
                      widget.onChanged?.call(value);
                      if (value == true) {
                        containerColor = darkNeutral800;
                      } else {
                        containerColor = darkNeutral600;
                      }
                    });
                  },
                  side: BorderSide(
                    color: widget.isSelected
                        ? primary50
                        : primary50, // Fix the typo here
                  ),
                ),
              ),
            ),
            Text(
              widget.text,
              style: TextStyle(
                color: primary50,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
