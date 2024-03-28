import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:timeago/timeago.dart' as timeago;

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.room,
  });

  final types.Room room;

  @override
  Widget build(BuildContext context) {
    types.Message? lastMessage =
        room.lastMessages?.isEmpty ?? true ? null : room.lastMessages!.first;

    String title = '';
    String subtitle = '';
    DateTime? updatedAt;

    if (lastMessage != null) {
      title = room.name != null
          ? room.name!
          : '${lastMessage.author.firstName} ${lastMessage.author.lastName}';
      if (lastMessage.updatedAt != null) {
        updatedAt = DateTime.fromMillisecondsSinceEpoch(lastMessage.updatedAt!);
      }
      if (lastMessage is types.TextMessage) {
        subtitle = room.name != null
            ? '${lastMessage.author.firstName} ${lastMessage.author.lastName}: ${lastMessage.text}'
            : lastMessage.text;
      }
    }

    return ListTile(
      onTap: () => _openChatPage(context),
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 24.0,
        child: Text(
          title.isNotEmpty ? title[0] : '',
          style: const TextStyle(
            fontSize: 14,
            height: 20 / 14,
            fontWeight: FontWeight.w400,
            color: primary1000,
          ),
        ),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: SizedBox(
        height: double.infinity,
        child: Text(
          updatedAt != null
              ? timeago.format(updatedAt,
                  locale: AppLocalizations.instance.locale.languageCode)
              : '',
          style: const TextStyle(
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
      titleTextStyle: const TextStyle(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w400,
        color: darkNeutral800,
        letterSpacing: 0.5,
      ),
      subtitleTextStyle: const TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
        color: darkNeutral800,
        letterSpacing: 0.25,
      ),
    );
  }

  void _openChatPage(BuildContext context) =>
      Navigator.of(context).pushNamed('/chat', arguments: room);
}