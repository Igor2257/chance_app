import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/chat_page/widgets/add_new_contect_widget.dart';
import 'package:chance_app/ui/pages/chat_page/widgets/user_checkbox_tile.dart';
import 'package:chance_app/ui/pages/chat_page/widgets/user_input_chip.dart';
import 'package:chance_app/ux/model/chat_user_model.dart';
import 'package:flutter/material.dart';

class NewGroupPage extends StatefulWidget {
  const NewGroupPage({super.key});

  @override
  State<NewGroupPage> createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
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
  final List<ChatUserModel> _selected = [];

  @override
  Widget build(BuildContext context) {
    print(_selected);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Нова група',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22,
            height: 28 / 22,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _selected.isEmpty ? null : () {},
            child: Text(
              'Далі',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 24 / 16,
                letterSpacing: 0.5,
                color: _selected.isEmpty ? darkNeutral400 : primary800,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: _selected
                      .map((t) => UserInputChip(
                            value: t,
                            onTap: _removeOnTap,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 8.0),
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Color(0xFFD9D9D9),
                ),
              ],
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
            children: entry.value
                .map((val) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: UserCheckboxTile(
                        isSelected: _selected.contains(val),
                        value: val,
                        onChanged: _changeCheckbox,
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
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

  void _changeCheckbox(ChatUserModel user) {
    if (_selected.contains(user)) {
      _selected.remove(user);
    } else {
      _selected.add(user);
    }
    setState(() {});
  }

  void _removeOnTap(ChatUserModel value) {
    setState(() {
      _selected.remove(value);
    });
  }
}
