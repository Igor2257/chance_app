import 'package:chance_app/ui/constans.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _openChatPage(context),
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 24.0,
        child: Text(
          'Д',
          style: TextStyle(
            fontSize: 14,
            height: 20 / 14,
            fontWeight: FontWeight.w400,
            color: primary1000,
          ),
        ),
      ),
      title: const Text(
        'Друзі',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: const Text(
        'Можемо зустрітися',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: SizedBox(
        height: double.infinity,
        child: Text(
          DateFormat('hh:mm').format(DateTime.now()),
          style: TextStyle(
            fontSize: 14,
            height: 20 / 14,
            fontWeight: FontWeight.w400,
            color: darkNeutral800,
            letterSpacing: 0.25,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      titleTextStyle: TextStyle(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w400,
        color: darkNeutral800,
        letterSpacing: 0.5,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
        color: darkNeutral800,
        letterSpacing: 0.25,
      ),
    );
  }

  void _openChatPage(BuildContext context) =>
      Navigator.of(context).pushNamed('/chat');
}
