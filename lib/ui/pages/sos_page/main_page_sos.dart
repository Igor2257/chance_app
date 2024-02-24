import 'package:chance_app/ui/constans.dart';
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
  SosContactsBloc get _sosContactsBloc {
    return BlocProvider.of<SosContactsBloc>(context);
  }

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
        title: const Text(
          'Екстрений дзвінок',
          style: TextStyle(
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
                    child: const Text(
                      'Замінити контакти',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                    child: const Text(
                      'Видалити контакт',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ];
            },
            onSelected: (String value) {
              if (value == 'replace') {
                // Заменить контакт
              } else if (value == 'delete') {
                Navigator.pushNamed(context, "/delete_contact");
              }
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
                text: 'Служба екстренноЇ допомоги 112',
                onPressed: () => _callContact('Contact 1'),
              ),
              ListView.builder(
                itemCount: _sosContactsBloc.contacts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 29),
                itemBuilder: (context, index) {
                  SosContactModel contactModel =
                      _sosContactsBloc.contacts[index];
                  return ContainerButton(
                    text: contactModel.name,
                    onPressed: () => _callContact(contactModel.phone),
                  );
                },
              ),
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
            "Додати",
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
                  left: 10.0,
                  right: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 164,
                      height: 56,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: darkNeutral600,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/add_contact');
                        },
                        child: Text(
                          "Контакт",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: primary50,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 164,
                      height: 56,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: darkNeutral600,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/add_group');
                        },
                        child: Text(
                          "Групу",
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
            ],
          ),
        );
      },
    );
  }
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