import 'package:chance_app/ux/model/chat_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCubit extends Cubit<List<ChatUserModel>> {
  SelectCubit() : super([]);

  void add(ChatUserModel value) {
    List<ChatUserModel> list = [...state, value];
    emit(list);
  }

  void remove(ChatUserModel value) {
    List<ChatUserModel> list = List.from(state)..remove(value);
    emit(list);
  }
}
