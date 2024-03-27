import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatHelper {
  static final FirebaseChatCore _instance = FirebaseChatCore.instance;

  static String? get userId => _instance.firebaseUser?.uid;

  static Stream<List<types.User>> get users => _instance.users();

  static Stream<List<types.Room>> get rooms => _instance.rooms();

  static Stream<List<types.Message>> messages(types.Room room) =>
      _instance.messages(room);

  static void sendMessage(String text, String roomId) {
    _instance.sendMessage(
      types.PartialText(text: text),
      roomId,
    );
  }

  static Future<types.Room> createRoom(types.User otherUser) =>
      _instance.createRoom(otherUser);

  static Future<types.Room> createGroupRoom({
    required String name,
    required List<types.User> users,
  }) {
    return _instance.createGroupRoom(name: name, users: users);
  }

  static Future<void> deleteRoom(String roomId) => _instance.deleteRoom(roomId);

  static void updateRoom(types.Room room) => _instance.updateRoom(room);

  const ChatHelper._();
}