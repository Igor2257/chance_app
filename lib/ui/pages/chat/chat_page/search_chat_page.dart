import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/chat/chat_page/blocs/search_cubit/search_cubit.dart';
import 'package:chance_app/ui/pages/chat/chat_page/widgets/chat_search_field.dart';
import 'package:chance_app/ui/pages/chat/chat_page/widgets/chat_user_tile.dart';

import 'package:chance_app/ux/helpers/chat_map_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class SearchChatPage extends StatelessWidget {
  const SearchChatPage({super.key, required this.list});

  final List<types.User> list;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<types.User>>(
      stream: FirebaseChatCore.instance.users(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: const CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return BlocProvider(
            create: (_) => SearchCubit(snapshot.data!),
            child: GestureDetector(
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
                        child: const Text(
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
                body: BlocBuilder<SearchCubit, List<types.User>>(
                  builder: (context, state) {
                    if (state.isEmpty) {
                      return ListView(
                        padding: const EdgeInsets.only(top: 24.0),
                        children: ChatMapUtils.generateSortMap(list)
                            .entries
                            .map((v) => _buildSortedList(context, v))
                            .toList(),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 16.0,
                      ),
                      itemBuilder: (context, index) =>
                          ChatUserTile(user: state[index]),
                      itemCount: state.length,
                    );
                  },
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: const SizedBox(),
        );
      },
    );
  }

  Widget _buildSortedList(
    BuildContext context,
    MapEntry<String, List<types.User>> entry,
  ) {
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
            children:
                entry.value.map((user) => ChatUserTile(user: user)).toList(),
          ),
        ),
      ],
    );
  }

  void _unFocus(BuildContext context) => FocusScope.of(context).unfocus();

  void _onCloseSearchPage(BuildContext context) => Navigator.of(context).pop();
}
