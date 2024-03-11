import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ux/bloc/sos_contacts_bloc/sos_contacts_bloc.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageSos extends StatefulWidget {
  const MainPageSos({super.key});

  @override
  State<MainPageSos> createState() => _MainPageSosState();
}

class _MainPageSosState extends State<MainPageSos> {
  // @override
  // void initState() {
  //   super.initState();
  //   BlocProvider.of<SosContactsBloc>(context).loadContacts();
  // }

  bool isDeletePage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context)
              .pushNamedAndRemoveUntil("/", (route) => false),
        ),
        title: Text(
          AppLocalizations.instance.translate("emergencyCall"),
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22,
            // fontFamily: ,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            color: beige50,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'replace',
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.black)),
                    ),
                    child: Text(
                      AppLocalizations.instance.translate("editContacts"),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.black)),
                    ),
                    child: Text(
                      AppLocalizations.instance.translate("deleteContact"),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ];
            },
            onSelected: (String value) {
              Navigator.pushNamed(context, "/delete_contact_sos",
                  arguments: value == 'replace' ? false : true);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 18,
          left: 10,
          right: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ContainerButton(
                text:
                    AppLocalizations.instance.translate("emergencyService112"),
                onPressed: () => _pushToCallScreen(
                  SosContactModel(
                    name: AppLocalizations.instance
                        .translate("emergencyService112"),
                    phone: "112",
                  ),
                ),
              ),
              BlocSelector<SosContactsBloc, SosContactsState,
                      List<SosGroupModel>>(
                  selector: (state) => state.contacts,
                  builder: (context, contacts) => ListView.builder(
                        itemCount: contacts.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 29),
                        itemBuilder: (context, index) {
                          SosGroupModel contactModel = contacts[index];
                          return ContainerButton(
                            text: contactModel.name.isNotEmpty
                                ? contactModel.name
                                : contactModel.contacts[0].name,
                            onPressed: () {
                              _pushToCallScreen(SosContactModel(
                                  name: contactModel.contacts[0].name,
                                  phone: contactModel.contacts[0].phone));
                            },
                          );
                        },
                      )),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 44,
        width: 113,
        margin: const EdgeInsets.only(bottom: 210, right: 5),
        child: FloatingActionButton.extended(
          onPressed: () {
            _showBottomSheet(context);
          },
          icon: Icon(
            Icons.add,
            color: primary50,
          ),
          label: Text(
            AppLocalizations.instance.translate("added"),
            style: TextStyle(
              color: primary50,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: primary1000,
        ),
      ),
    );
  }

  void _callContact(String contactName) {}

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 4,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 4,
                width: 32,
                decoration: BoxDecoration(color: beige400),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                  // left: 10.0,
                  // right: 10.0,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 164,
                        height: 56,
                        decoration: BoxDecoration(
                          color: darkNeutral600,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/add_contact');
                          },
                          child: Text(
                            AppLocalizations.instance.translate("contact"),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: primary50,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 164,
                        height: 56,
                        decoration: BoxDecoration(
                          color: darkNeutral600,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/add_group');
                          },
                          child: Text(
                            AppLocalizations.instance.translate("group"),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: primary50,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _pushToCallScreen(SosContactModel contactModel) =>
      Navigator.pushNamed(context, "/call_contact_sos",
          arguments: contactModel);
}

class ContainerButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ContainerButton(
      {super.key, required this.text, required this.onPressed});

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
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            // fontFamily: ,
            color: primary50,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
