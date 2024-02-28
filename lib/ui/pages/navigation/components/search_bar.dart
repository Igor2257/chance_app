import 'package:chance_app/ui/constans.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar(
      {super.key,
      required this.textEditingController,
      required this.focusNode});

  final TextEditingController textEditingController;
  final FocusNode focusNode;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late final TextEditingController textEditingController;
  late final FocusNode focusNode;

  @override
  void initState() {
    textEditingController = widget.textEditingController;
    focusNode = widget.focusNode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: beigeTransparent,boxShadow: const [BoxShadow(
            blurRadius: 6,
            color: Colors.black26,
            offset: Offset(0, 0),
            spreadRadius: 2,
            blurStyle: BlurStyle.normal)]),
        child: TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: const InputDecoration(border: InputBorder.none),
        ));
  }
}
