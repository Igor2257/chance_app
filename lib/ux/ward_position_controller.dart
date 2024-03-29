import 'dart:async';

import 'package:chance_app/ux/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:chance_app/ux/hive_crud.dart';
import 'package:chance_app/ux/model/ward_location_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WardPositionController {
  late StreamSubscription<WardLocationModel?> _stream;

  WardPositionController(BuildContext context) {
    _stream = Supabase.instance.client
        .from('ward_location')
        .stream(primaryKey: ['id']).map<WardLocationModel?>((maps) {
      List<WardLocationModel> list =
          maps.map((map) => WardLocationModel.fromJson(map)).toList();
      if (maps
          .toList()
          .any((element) => element["toUserEmail"] == HiveCRUD().user!.email)) {
        return list.firstWhere(
            (element) => element.toUserEmail == HiveCRUD().user!.email);
      }
      return null;
    }).listen((event) {
      if (event != null) {
        try {
          BlocProvider.of<NavigationBloc>(context)
              .add(ChangeWardLocation(event));
        } catch (_) {}
      }
    })
      ..resume();
  }

  void cancel() {
    _stream.cancel();
  }

  void pause() {
    _stream.pause();
  }

  void resume() {
    _stream.resume();
  }
}
