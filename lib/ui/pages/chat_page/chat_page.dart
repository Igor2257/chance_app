import 'dart:async';
import 'dart:convert';

import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/chat_page/widgets/chat_bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Socket? socket;
  final TextEditingController _controller = TextEditingController();
  StreamSocket streamSocket = StreamSocket();

  final List<String> _testUsers = <String>[
    'Olives',
    'Tomato',
    'Cheese',
    'Pepperoni',
    'Bacon',
    'Onion',
    'Jalapeno',
    'Mushrooms',
    'Pineapple',
  ];

  @override
  void initState() {
    try {
      socket = io(
        'http://139.28.37.11:56565/',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'withCredentials': true}) // optional
            .build(),
      );

      socket?.onConnect((_) {
        print('connect');
        socket?.emit('msg', 'connect');
      });
      socket?.onConnectError((e) {
        print('onConnectError - $e');
        socket?.emit('msg', 'test');
      });
      socket?.onConnecting((e) {
        print('onConnecting');
        socket?.emit('msg', 'test');
      });
      socket?.onError((e) {
        print('onError $e');
        socket?.emit('msg', 'test');
      });
      socket?.onReconnect((_) {
        print('onReconnect');
        socket?.emit('msg', 'test');
      });
      socket?.on('text-chat', (data) {
        print(data);
        streamSocket.addResponse(data);
      });
      socket?.on('msg', (data) {
        print(data);
        //streamSocket.addResponse(data);
      });
      socket?.onDisconnect((_) => print('disconnect'));
      socket?.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  void dispose() {
    socket?.disconnect();
    socket?.dispose();

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _unFocus(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Юзер',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 22,
              height: 28 / 22,
            ),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: streamSocket.getResponse,
          builder: (context, snapshot) {
            print(snapshot);

            /// We are waiting for incoming data data
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }

            /// We have an active connection and we have received data
            // if (snapshot.connectionState == ConnectionState.active &&
            //     snapshot.hasData) {
            return ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: _testUsers.length,
              itemBuilder: (context, index) {
                return ChatBubbleWidget(
                  text: _testUsers[index],
                  isMine: index % 2 == 0,
                );
              },
            );
            //}

            /// When we have closed the connection
            if (snapshot.connectionState == ConnectionState.done) {
              return const Center(
                child: Text(
                  'No more data',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              );
            }

            /// For all other situations, we display a simple "No data"
            /// message
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
        decoration: InputDecoration(
          fillColor: background,
          filled: true,
          suffixIcon: IconButton(
            onPressed: _onSendBtnTap,
            icon: const Icon(Icons.send),
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
    );
  }

  Future<void> _onSendBtnTap() async {
    // Map<String, dynamic> map = {

    // };
    try {
      //await _channel?.ready;
      _controller.clear();
      if (mounted) {
        _unFocus(context);
        print('socket - $socket');
        socket?.emit(
          'text-chat',
          json.encode(
            {
              'name': 'Name',
              'fromUserId': '10',
              'message': _controller.text,
            },
          ),
        );
        //_channel?.sink.add('Info');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  void _unFocus(BuildContext context) => FocusScope.of(context).unfocus();
}
