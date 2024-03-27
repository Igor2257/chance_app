import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/chat_page/widgets/custom_dialog.dart';
import 'package:chance_app/ux/extensions/chat_user_name.dart';
import 'package:chance_app/ux/helpers/chat_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:collection/collection.dart';

class ChatSettingsPage extends StatelessWidget {
  const ChatSettingsPage({super.key, required this.room});

  final types.Room room;

  @override
  Widget build(BuildContext context) {
    types.User? admin = _getAdmin(room.users);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Група',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22,
            height: 28 / 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32.0,
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage:
                  room.imageUrl != null ? NetworkImage(room.imageUrl!) : null,
              radius: 40.0,
              backgroundColor: darkNeutral300,
              child: room.imageUrl == null
                  ? Text(
                      room.name != null && room.name!.isNotEmpty
                          ? room.name![0]
                          : '',
                      style: TextStyle(
                        fontSize: 32,
                        height: 40 / 32,
                        color: primary1000,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 24.0),
            if (room.name != null)
              Text(
                room.name ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  height: 28 / 22,
                  color: Color(0xff212833),
                ),
              ),
            Text(
              '${room.users.length} контакти',
              style: TextStyle(
                  fontSize: 12, height: 16 / 12, color: darkNeutral400),
            ),
            const SizedBox(height: 60.0),
            if (admin != null) ...[
              _buildAdminTile(admin),
              const SizedBox(height: 24.0),
            ],
            Expanded(
              child: _buildUsersList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          room.type == types.RoomType.group && admin?.id == ChatHelper.userId
              ? RoundedButton(
                  height: 48.0,
                  color: Colors.transparent,
                  border: Border.all(
                    color: darkNeutral800,
                  ),
                  margin: const EdgeInsets.all(16.0),
                  child: Text(
                    'Змінити',
                    style: TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15,
                      color: darkNeutral800,
                    ),
                  ),
                  onPress: () => _openChangeGroupPage(context),
                )
              : RoundedButton(
                  height: 48.0,
                  color: red900,
                  margin: const EdgeInsets.all(16.0),
                  child: Text(
                    'Покинути групу',
                    style: TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15,
                      color: primary50,
                    ),
                  ),
                  onPress: () => _leaveGroup(context),
                ),
    );
  }

  Column _buildAdminTile(types.User admin) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              admin.fullName,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 24 / 16,
                letterSpacing: 0.5,
                color: darkNeutral1000,
              ),
            ),
            Text(
              'Адмін',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 24 / 16,
                letterSpacing: 0.5,
                color: darkNeutral1000,
              ),
            ),
          ],
        ),
        Divider(
          height: 16,
          thickness: 1,
          color: const Color(0xFFB1B3B7).withOpacity(.4),
        )
      ],
    );
  }

  ListView _buildUsersList() {
    List<types.User> usersWithoutAdmin = _getListWithoutAdmin(room.users);

    return ListView.separated(
      itemBuilder: (context, index) => Text(
        usersWithoutAdmin[index].fullName,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 24 / 16,
          letterSpacing: 0.5,
          color: darkNeutral1000,
        ),
      ),
      itemCount: usersWithoutAdmin.length,
      separatorBuilder: (_, __) {
        return Divider(
          height: 16,
          thickness: 1,
          color: const Color(0xFFB1B3B7).withOpacity(.4),
        );
      },
    );
  }

  List<types.User> _getListWithoutAdmin(List<types.User> users) =>
      users.where((u) => u.role != types.Role.admin).toList();

  types.User? _getAdmin(List<types.User> users) =>
      users.firstWhereOrNull((u) => u.role == types.Role.admin);

  types.User _getMe(List<types.User> users) =>
      users.firstWhere((u) => u.id == ChatHelper.userId);

  void _openChangeGroupPage(BuildContext context) =>
      Navigator.of(context).pushNamed('/change_group', arguments: room);

  void _leaveGroup(BuildContext context) async {
    bool? value = await CustomDialog.show<bool?>(
        context: context, title: 'Ви впевнені, що хочете покинути групу?');
    if (value == true) {
      List<types.User> users = List.from(room.users);
      types.User me = _getMe(users);
      users.remove(me);

      ChatHelper.updateRoom(room.copyWith(users: users));

      if (!context.mounted) return;

      Navigator.of(context)
          .pushNamedAndRemoveUntil('/chats', ModalRoute.withName('/'));
    }
  }
}
