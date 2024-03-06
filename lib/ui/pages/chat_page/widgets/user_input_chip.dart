import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/model/chat_user_model.dart';
import 'package:flutter/material.dart';

class UserInputChip extends StatelessWidget {
  const UserInputChip({
    super.key,
    required this.value,
    required this.onTap,
  });

  final ChatUserModel value;
  final ValueChanged<ChatUserModel> onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(value),
      child: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: Ink(
          padding: const EdgeInsets.symmetric(
            vertical: 2.0,
            horizontal: 4.0,
          ),
          decoration: BoxDecoration(
            color: darkNeutral300,
            borderRadius: const BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          child: Text(
            value.name,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 20 / 14,
              color: darkNeutral1000,
              letterSpacing: 0.25,
            ),
          ),
        ),
      ),
    );
  }
}
