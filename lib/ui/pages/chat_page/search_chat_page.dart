import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/chat_page/blocs/search_cubit/search_cubit.dart';
import 'package:chance_app/ux/model/chat_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchChatPage extends StatefulWidget {
  const SearchChatPage({super.key, required this.list});

  final List<ChatUserModel> list;

  @override
  State<SearchChatPage> createState() => _SearchChatPageState();
}

class _SearchChatPageState extends State<SearchChatPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _unFocus(context),
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.search,
                    textCapitalization: TextCapitalization.words,
                    onChanged: context.read<SearchCubit>().search,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 24 / 16,
                      color: darkNeutral800,
                      letterSpacing: 0.5,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                      isDense: true,
                      suffixIconConstraints: const BoxConstraints(
                        maxWidth: 18.0,
                        maxHeight: 18.0,
                      ),
                      suffixIcon: IconButton(
                        iconSize: 18,
                        padding: EdgeInsets.zero,
                        onPressed: () => _onClearBtnTap(context),
                        icon: const Icon(Icons.close),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                  ),
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
            builder: (context, state) {
              if (state.isEmpty) {
                return ListView(
                  padding: const EdgeInsets.only(top: 24.0),
                  children: _generateSortMap(widget.list)
                      .entries
                      .map(_buildSortedList)
                      .toList(),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 16.0,
                ),
                itemBuilder: (context, index) => _buildChatTile(state[index]),
                itemCount: state.length,
              );
            },
          )),
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

  void _onClearBtnTap(BuildContext context) {
    _unFocus(context);
    _controller.clear();
    context.read<SearchCubit>().clear();
  }

  void _unFocus(BuildContext context) => FocusScope.of(context).unfocus();

  void _onCloseSearchPage(BuildContext context) => Navigator.of(context).pop();

  void _openChat(BuildContext context) =>
      Navigator.of(context).pushNamed('/chat');
}
