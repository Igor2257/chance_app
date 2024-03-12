import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/chat_page/blocs/search_cubit/search_cubit.dart';
import 'package:chance_app/ui/pages/chat_page/blocs/select_cubit/select_cubit.dart';
import 'package:chance_app/ui/pages/chat_page/widgets/chat_search_field.dart';
import 'package:chance_app/ui/pages/chat_page/widgets/user_checkbox_tile.dart';
import 'package:chance_app/ux/model/chat_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchGroupPageParameters {
  const SearchGroupPageParameters(this.allUsers, this.selectedUsers);

  final List<ChatUserModel> allUsers;
  final List<ChatUserModel> selectedUsers;
}

class SearchGroupPage extends StatefulWidget {
  const SearchGroupPage({super.key, required this.list});

  final List<ChatUserModel> list;

  @override
  State<SearchGroupPage> createState() => _SearchGroupPageState();
}

class _SearchGroupPageState extends State<SearchGroupPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _unFocus(context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              const Flexible(
                child: ChatSearchField(),
              ),
              const SizedBox(width: 16.0),
              TextButton(
                onPressed: () => _onCloseSearchPage(context),
                child: Text(
                  'Скасувати',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 24 / 16,
                    color: darkNeutral1000,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<SearchCubit, List<ChatUserModel>>(
          builder: (context, searched) {
            if (searched.isEmpty) {
              return ListView(
                padding: const EdgeInsets.only(top: 24.0),
                children: _generateSortMap(widget.list)
                    .entries
                    .map(_buildSortedList)
                    .toList(),
              );
            }

            return BlocBuilder<SelectCubit, List<ChatUserModel>>(
              builder: (context, selected) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                    horizontal: 16.0,
                  ),
                  itemBuilder: (context, index) {
                    return _buildChatTile(
                      searched[index],
                      selected.contains(searched[index]),
                    );
                  },
                  itemCount: searched.length,
                );
              },
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(
            16.0,
            16.0,
            16.0,
            16.0 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: RoundedButton(
            color: primary1000,
            child: Text(
              'Додати',
              style: TextStyle(
                fontSize: 16,
                height: 24 / 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
                color: beige0,
              ),
            ),
            onPress: () => _onAddBtnTap(context),
          ),
        ),
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
        BlocBuilder<SelectCubit, List<ChatUserModel>>(
          builder: (context, selected) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: entry.value
                    .map((val) => _buildChatTile(val, selected.contains(val)))
                    .toList(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildChatTile(ChatUserModel val, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: UserCheckboxTile(
        key: ValueKey(val),
        isSelected: isSelected,
        value: val,
        onChanged: _changeCheckbox,
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

  void _unFocus(BuildContext context) => FocusScope.of(context).unfocus();

  void _onCloseSearchPage(BuildContext context) => Navigator.of(context).pop();

  void _changeCheckbox(ChatUserModel user) {
    SelectCubit cubit = context.read<SelectCubit>();
    if (cubit.state.contains(user)) {
      cubit.remove(user);
    } else {
      cubit.add(user);
    }
  }

  void _onAddBtnTap(BuildContext context) =>
      Navigator.of(context).pop(context.read<SelectCubit>().state);
}
