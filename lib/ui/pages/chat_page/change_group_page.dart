import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/chat_page/widgets/custom_dialog.dart';
import 'package:chance_app/ui/pages/reminders_page/components/labeled_text_field.dart';
import 'package:chance_app/ux/extensions/chat_user_name.dart';
import 'package:chance_app/ux/helpers/chat_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:collection/collection.dart';

class ChangeGroupPage extends StatefulWidget {
  const ChangeGroupPage({super.key, required this.room});

  final types.Room room;

  @override
  State<ChangeGroupPage> createState() => _ChangeGroupPageState();
}

class _ChangeGroupPageState extends State<ChangeGroupPage> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.room.name,
  );
  late final types.User? admin = _getAdmin(widget.room.users);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _unFocus(context),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                backgroundImage: widget.room.imageUrl != null
                    ? NetworkImage(widget.room.imageUrl!)
                    : null,
                radius: 40.0,
                backgroundColor: darkNeutral300,
                child: widget.room.imageUrl == null
                    ? Text(
                        widget.room.name != null && widget.room.name!.isNotEmpty
                            ? widget.room.name![0]
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
              LabeledTextField(
                controller: _controller,
                label: "Назва",
                hintText: "ім'я",
                isPhone: false,
                onChanged: (value) {},
              ),
              const SizedBox(height: 60.0),
              if (admin != null) ...[
                _buildAdminTile(admin!),
                const SizedBox(height: 24.0),
              ],
              Expanded(
                child: _buildUsersList(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedButton(
                height: 48.0,
                color: primary1000,
                onPress: _controller.text.trim().isNotEmpty &&
                        _controller.text.trim() != widget.room.name
                    ? () => _updateRoom(context)
                    : null,
                child: Text(
                  'Готово',
                  style: TextStyle(
                    fontSize: 16,
                    height: 24 / 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15,
                    color: primary50,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              RoundedButton(
                height: 48.0,
                color: red900,
                child: Text(
                  'Покинути та видалити групу',
                  style: TextStyle(
                    fontSize: 16,
                    height: 24 / 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15,
                    color: primary50,
                  ),
                ),
                onPress: () => _deleteGroup(context),
              ),
            ],
          ),
        ),
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
    List<types.User> usersWithoutAdmin =
        _getListWithoutAdmin(widget.room.users);

    return ListView.separated(
      itemBuilder: (context, index) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            usersWithoutAdmin[index].fullName,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 24 / 16,
              letterSpacing: 0.5,
              color: darkNeutral1000,
            ),
          ),
          TextButton(
            onPressed: () => _removeUser(context, usersWithoutAdmin[index]),
            child: Text(
              'Видалити',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 20 / 14,
                letterSpacing: 0.25,
                color: red900,
              ),
            ),
          ),
        ],
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

  void _deleteGroup(BuildContext context) async {
    bool? value = await CustomDialog.show<bool?>(
      context: context,
      title: 'Ви впевнені, що хочете покинути та видалити групу?',
    );
    if (value == true) {
      await ChatHelper.deleteRoom(widget.room.id);

      if (!context.mounted) return;

      Navigator.of(context)
          .pushNamedAndRemoveUntil('/chats', ModalRoute.withName('/'));
    }
  }

  void _removeUser(BuildContext context, types.User user) async {
    bool? value = await CustomDialog.show<bool?>(
      context: context,
      title: 'Ви впевнені, що хочете видалити друга?',
      actionText: 'Видалити',
    );
    if (value == true) {
      List<types.User> users = List.from(widget.room.users);
      users.remove(user);

      ChatHelper.updateRoom(widget.room.copyWith(users: users));

      if (!context.mounted) return;

      Navigator.of(context)
          .pushNamedAndRemoveUntil('/chats', ModalRoute.withName('/'));
    }
  }

  void _updateRoom(BuildContext context) {
    ChatHelper.updateRoom(widget.room.copyWith(name: _controller.text.trim()));

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/chats', ModalRoute.withName('/'));
  }

  void _unFocus(BuildContext context) => FocusScope.of(context).unfocus();
}
