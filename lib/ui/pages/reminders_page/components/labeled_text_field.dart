import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LabeledTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool isPhone;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.isPhone,
    required this.controller,
    required Null Function(dynamic value) onChanged,
  });

  @override
  LabeledTextFieldState createState() => LabeledTextFieldState();
}

class LabeledTextFieldState extends State<LabeledTextField> {
  String? errorText;

  static LabeledTextFieldState? nameTextField;
  static LabeledTextFieldState? phoneTextField;

  bool validateInput(String input) {
    if (widget.isPhone) {
      final RegExp phoneRegex = RegExp(r'^\+380\d*$');
      return phoneRegex.hasMatch(input);
    } else {
      final RegExp nameRegex = RegExp(r'^[а-яА-Яa-zA-Z\s]{3,}$');
      return nameRegex.hasMatch(input);
    }
  }

  bool validate() {
    return validateInput(widget.controller.text);
  }

  void clear() {
    widget.controller.clear();
    errorText = null;
  }

  @override
  void initState() {
    super.initState();
    if (widget.isPhone) {
      phoneTextField = this;
    } else {
      nameTextField = this;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              errorText: errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: beige300,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: beige300,
                  width: 1.0,
                ),
              ),
              // prefixText: widget.isPhone ? '+380 ' : null,
              // prefixStyle: widget.isPhone
              //     ? const TextStyle(color: Colors.red, fontSize: 18)
              //     : null,
            ),
            onChanged: (value) {
              setState(() {
                errorText = null;
              });
            },
            onEditingComplete: () {
              if (!validate()) {
                setState(() {
                  Fluttertoast.showToast(
                      msg: AppLocalizations.instance
                          .translate("checkTheEnteredData"));
                });
              }
            },
          ),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
