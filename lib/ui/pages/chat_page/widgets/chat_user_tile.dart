import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/extensions/chat_user_name.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class ChatUserTile extends StatelessWidget {
  const ChatUserTile({super.key, required this.user});

  final types.User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openChat(context, user),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          user.fullName,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            height: 24 / 16,
            letterSpacing: 0.5,
            color: darkNeutral1000,
          ),
        ),
      ),
    );
  }

  void _openChat(BuildContext context, types.User user) async {
    final room = await FirebaseChatCore.instance.createRoom(user);

    if (!context.mounted) return;

    Navigator.of(context).pushNamed('/chat', arguments: room);
  }
}
