import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/chat_page/blocs/select_cubit/select_cubit.dart';
import 'package:chance_app/ui/pages/chat_page/widgets/add_new_contect_widget.dart';
import 'package:chance_app/ui/pages/chat_page/widgets/user_checkbox_tile.dart';
import 'package:chance_app/ui/pages/chat_page/widgets/user_input_chip.dart';
import 'package:chance_app/ux/helpers/chat_map_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class NewGroupPage extends StatefulWidget {
  const NewGroupPage({super.key});

  @override
  State<NewGroupPage> createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectCubit, List<types.User>>(
      builder: (context, state) {
        bool isEmpty = state.isEmpty;

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
                onPressed: isEmpty ? null : () => _openCreateGroupPage(context),
                child: Text(
                  'Далі',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 24 / 16,
                    letterSpacing: 0.5,
                    color: isEmpty ? darkNeutral400 : primary800,
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
              GestureDetector(
                onTap: () => _onSearchTap(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isEmpty)
                        const Text(
                          'Пошук контакту',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            height: 24 / 16,
                            letterSpacing: 0.5,
                            color: Color(0xFFD9D9D9),
                          ),
                        )
                      else
                        Wrap(
                          spacing: 4.0,
                          runSpacing: 4.0,
                          children: state
                              .map((v) => UserInputChip(value: v))
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
              ),
              const AddNewContactWidget(),
              Expanded(
                child: StreamBuilder<List<types.User>>(
                  stream: FirebaseChatCore.instance.users(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasData) {
                      return ListView(
                        children: ChatMapUtils.generateSortMap(snapshot.data!)
                            .entries
                            .map((entry) => _buildSortedList(entry, state))
                            .toList(),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortedList(
    MapEntry<String, List<types.User>> entry,
    List<types.User> list,
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
            children: entry.value
                .map((val) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: UserCheckboxTile(
                        isSelected: list.contains(val),
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

  void _changeCheckbox(types.User user) {
    SelectCubit cubit = context.read<SelectCubit>();
    if (cubit.state.contains(user)) {
      cubit.remove(user);
    } else {
      cubit.add(user);
    }
  }

  Future<void> _onSearchTap(BuildContext context) async {
    SelectCubit cubit = context.read<SelectCubit>();
    final result = await Navigator.of(context).pushNamed(
      '/search_group',
      arguments: cubit.state,
    ) as List<types.User>?;
    if (result != null) {
      cubit.addAll(result);
    }
  }

  void _openCreateGroupPage(BuildContext context) => Navigator.of(context)
      .pushNamed('/create_group', arguments: context.read<SelectCubit>().state);
}
