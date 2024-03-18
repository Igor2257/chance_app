import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:flutter/material.dart';

class GroupDetailsScreen extends StatelessWidget {
  final SosGroupModel group;

  const GroupDetailsScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          group.name,
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
          top: 18,
          left: 10,
          right: 10,
        ),
        child: ListView.builder(
          itemCount: group.contacts.length,
          itemBuilder: (context, index) {
            final contact = group.contacts[index];
            return ContainerButton(
              text: contact.name,
              onPressed: () {},
              contacts: const [],
            );
          },
        ),
      ),
    );
  }
}

class ContainerButton extends StatelessWidget {
  final String text;
  final List<SosContactModel> contacts;
  final VoidCallback onPressed;

  const ContainerButton({
    super.key,
    required this.text,
    required this.contacts,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: darkNeutral600,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        title: Center(
          child: Text(
            text,
            style: TextStyle(
              color: primary50,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
