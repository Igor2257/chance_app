import 'package:chance_app/ui/constans.dart';
import 'package:flutter/material.dart';

class InputRemindersLayout extends StatefulWidget {
  const InputRemindersLayout(
      {super.key,
      required this.textEditingController,
      required this.title,
      required this.subTitle,
      required this.saveData, required this.clearData});

  final TextEditingController textEditingController;
  final String title, subTitle;
  final Function(String value) saveData;
  final Function() clearData;

  @override
  State<InputRemindersLayout> createState() => _InputRemindersLayoutState();
}

class _InputRemindersLayoutState extends State<InputRemindersLayout> {
  late final TextEditingController textEditingController;
  late final String title, subTitle;
  String errorText = "";
  final FocusNode focusNode = FocusNode();

  GlobalKey<FormState> form = GlobalKey<FormState>();
  bool isError = false;

  @override
  void initState() {
    textEditingController = widget.textEditingController;
    title = widget.title;
    subTitle = widget.subTitle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: isError ? red900 : beige300),
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 16, color: isError ? red900 : primaryText),
                      textInputAction: TextInputAction.done,
                      validator: (_) {
                        widget.saveData(textEditingController.text);
                        return null;
                      },
                      onChanged: widget.saveData,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                            fontSize: 14,
                            color: isError ? red900 : primaryText),
                        labelText: title
                      ),
                      focusNode: focusNode,
                      controller: textEditingController,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        textEditingController.text = "";
                        widget.clearData();
                        focusNode.unfocus();
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: beige500,
                      )),
                ],
              ),
            ),
            if (errorText.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  errorText,
                  style: TextStyle(fontSize: 14, color: red900),
                ),
              ),
          ],
        ));
  }
}
