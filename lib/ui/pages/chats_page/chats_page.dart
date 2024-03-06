import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/chats_page/widgets/chat_tile.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Спілкування',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22,
            height: 28 / 22,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: 10,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) => const ChatTile(),
        separatorBuilder: (_, __) => Divider(
          thickness: 1.0,
          height: 0.0,
          color: Colors.black.withOpacity(.1),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onFloatingActionBtnTap(context),
        backgroundColor: primary900,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _onFloatingActionBtnTap(BuildContext context) =>
      Navigator.of(context).pushNamed('/create_chat');
}
