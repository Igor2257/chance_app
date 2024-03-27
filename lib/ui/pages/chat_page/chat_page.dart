import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/chat_page/widgets/chat_bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.room});

  final types.Room room;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  late final Stream<List<types.Message>> _messagesStream =
      FirebaseChatCore.instance.messages(widget.room);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _unFocus(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.room.name ?? 'Chat',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 22,
              height: 28 / 22,
            ),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<List<types.Message>>(
          stream: _messagesStream,
          builder: (context, snapshot) {
            // We are waiting for incoming data data
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // We have an active connection and we have received data
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.hasData) {
              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(16.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  types.Message message = snapshot.data![index];
                  if (message is types.TextMessage) {
                    return ChatBubbleWidget(message: message);
                  }
                  return const SizedBox();
                },
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return const Center(
                child: Text(
                  'No more data',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    height: 28 / 22,
                  ),
                ),
              );
            }

            return const Center(
              child: Text('No messages'),
            );
          },
        ),
        bottomNavigationBar: _buildMessageTextField(context),
      ),
    );
  }

  Widget _buildMessageTextField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: darkNeutral800,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
      ),
      child: SafeArea(
        child: TextField(
          controller: _controller,
          textInputAction: TextInputAction.send,
          textCapitalization: TextCapitalization.sentences,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17,
            height: 22 / 17,
            letterSpacing: -0.4,
            color: primary1000,
          ),
          onEditingComplete: _onSendBtnTap,
          decoration: InputDecoration(
            fillColor: background,
            filled: true,
            suffixIcon: IconButton(
              onPressed: _onSendBtnTap,
              icon: Icon(
                Icons.send,
                color: primary1000,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            hintText: 'Що нового?',
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
              height: 22 / 17,
              letterSpacing: -0.4,
              color: Color(0xFF8E8E93),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
        ),
      ),
    );
  }

  void _onSendBtnTap() {
    if (_controller.text.isNotEmpty) {
      FirebaseChatCore.instance.sendMessage(
        types.PartialText(text: _controller.text),
        widget.room.id,
      );
      _controller.clear();
    }
  }

  void _unFocus(BuildContext context) => FocusScope.of(context).unfocus();
}
