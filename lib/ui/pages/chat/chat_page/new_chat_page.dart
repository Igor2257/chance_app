import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/chat/chat_page/widgets/add_new_contect_widget.dart';
import 'package:chance_app/ui/pages/chat/chat_page/widgets/chat_user_tile.dart';
import 'package:chance_app/ux/helpers/chat_map_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class NewChatPage extends StatelessWidget {
  const NewChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Новий Чат',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22,
            height: 28 / 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32.0),
          GestureDetector(
            onTap: () => _onTextFieldTap(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Пошук контакту',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 24 / 16,
                      letterSpacing: 0.5,
                      color: Color(0xFFD9D9D9),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: Color(0xFFD9D9D9),
                  ),
                ],
              ),
            ),
          ),
          const AddNewContactWidget(),
          Expanded(
            child: StreamBuilder<List<types.User>>(
              stream: FirebaseChatCore.instance.users(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  return ListView(
                    children: ChatMapUtils.generateSortMap(snapshot.data!)
                        .entries
                        .map(_buildSortedList)
                        .toList(),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortedList(MapEntry<String, List<types.User>> entry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: darkNeutral300,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            entry.key,
            style: const TextStyle(
              fontSize: 14,
              height: 20 / 14,
              letterSpacing: 0.1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                entry.value.map((user) => ChatUserTile(user: user)).toList(),
          ),
        ),
      ],
    );
  }

  void _onTextFieldTap(BuildContext context) =>
      Navigator.of(context).pushNamed('/search_chat');
}
