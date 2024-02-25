import 'package:chance_app/ui/constans.dart';
import 'package:flutter/material.dart';

class InputMyInfoLayout extends StatefulWidget {
  const InputMyInfoLayout(
      {super.key, required this.title, required this.textEditingController});

  final String title;
  final TextEditingController textEditingController;

  @override
  State<InputMyInfoLayout> createState() => _InputMyInfoLayoutState();
}

class _InputMyInfoLayoutState extends State<InputMyInfoLayout> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = widget.textEditingController;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 14, color: primaryText),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
              border: Border.all(color: beige300),
              borderRadius: BorderRadius.circular(16)),
          child: TextFormField(
            enabled: false,
            style: TextStyle(fontSize: 16, color: primaryText),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            controller: textEditingController,
          ),
        ),
      ],
    );
  }
}
