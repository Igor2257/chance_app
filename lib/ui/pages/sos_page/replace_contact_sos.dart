import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ui/pages/reminders_page/components/labeled_text_field.dart';
import 'package:chance_app/ux/bloc/sos_contacts_bloc/sos_contacts_bloc.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReplaceContactSosScreen extends StatefulWidget {
  const ReplaceContactSosScreen({super.key});

  @override
  State<ReplaceContactSosScreen> createState() => _ReplaceContactSosState();
}

class _ReplaceContactSosState extends State<ReplaceContactSosScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late SosGroupModel contactModel;
  SosContactsBloc get _sosContactsBloc {
    return BlocProvider.of<SosContactsBloc>(context);
  }

  @override
  void didChangeDependencies() {
    contactModel = ModalRoute.of(context)!.settings.arguments as SosGroupModel;
    super.didChangeDependencies();
    nameController = TextEditingController(text: contactModel.contacts[0].name);
    phoneController =
        TextEditingController(text: contactModel.contacts[0].phone);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SosContactsBloc, SosContactsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.instance.translate("editingContact")),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                LabeledTextField(
                  controller: nameController,
                  label: AppLocalizations.instance.translate("name"),
                  hintText: AppLocalizations.instance.translate("name"),
                  isPhone: false,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 8),
                LabeledTextField(
                  controller: phoneController,
                  label: AppLocalizations.instance.translate("phone"),
                  hintText: '+380',
                  isPhone: true,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      print('Button pressed');
                      if (_validateForm()) {
                        _sosContactsBloc.add(EditContact(
                            contactModel: contactModel.copyWith(contacts: [
                          SosContactModel(
                              name: nameController.text,
                              phone: phoneController.text,
                              id: contactModel.id)
                        ])));

                        Navigator.of(context)
                            .pushNamedAndRemoveUntil("/sos", (route) => false);
                        nameController.clear();
                        phoneController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizations.instance
                                .translate("checkTheCorrectnessOfTheData")),
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
                      AppLocalizations.instance.translate("saveTheContact"),
                      style: const TextStyle(
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
      },
    );
  }

  bool _validateForm() {
    bool isValid =
        nameController.text.isNotEmpty && phoneController.text.isNotEmpty;
    return isValid;
  }
}
