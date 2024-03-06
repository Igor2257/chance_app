import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/chat_page/widgets/add_new_contect_widget.dart';
import 'package:chance_app/ux/model/chat_user_model.dart';
import 'package:flutter/material.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({super.key});

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  final List<ChatUserModel> _testUsers = <ChatUserModel>[
    const ChatUserModel(name: 'Olives'),
    const ChatUserModel(name: 'Tomato'),
    const ChatUserModel(name: 'Cheese'),
    const ChatUserModel(name: 'Pepperoni'),
    const ChatUserModel(name: 'Bacon'),
    const ChatUserModel(name: 'Onion'),
    const ChatUserModel(name: 'Jalapeno'),
    const ChatUserModel(name: 'Mushrooms'),
    const ChatUserModel(name: 'Pineapple'),
  ];

  late final Map<String, List<ChatUserModel>> _users =
      _generateSortMap(_testUsers);

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
          if (_users.isNotEmpty)
            Expanded(
              child: ListView(
                children: _users.entries.map(_buildSortedList).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSortedList(MapEntry<String, List<ChatUserModel>> entry) {
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
            children: entry.value.map(_buildChatTile).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildChatTile(ChatUserModel val) {
    return GestureDetector(
      onTap: () => _openChat(context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          val.name,
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

  Map<String, List<ChatUserModel>> _generateSortMap(List<ChatUserModel> list) {
    Map<String, List<ChatUserModel>> map = {};
    list.sort((a, b) => a.name.compareTo(b.name));
    for (ChatUserModel item in list) {
      String firstLetter = item.name[0].toUpperCase();
      map.putIfAbsent(firstLetter, () => []);
      map[firstLetter]!.add(item);
    }

    return map;
  }

  void _onTextFieldTap(BuildContext context) => Navigator.of(context).pushNamed('/search');

  void _openChat(BuildContext context) {}
}
