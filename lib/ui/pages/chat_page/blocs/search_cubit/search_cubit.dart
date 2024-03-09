import 'package:chance_app/ux/model/chat_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<List<ChatUserModel>> {
  final List<ChatUserModel> _list;

  SearchCubit(this._list) : super([]);

  void search(String value) {
    if (value.isEmpty) {
      return clear();
    }
    return emit(
      _list
          .where((v) => v.name.toLowerCase().startsWith(value.toLowerCase()))
          .toList(),
    );
  }

  void clear() => emit([]);
}
