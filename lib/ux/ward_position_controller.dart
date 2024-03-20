import 'dart:async';

import 'package:chance_app/ux/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:chance_app/ux/hive_crud.dart';
import 'package:chance_app/ux/model/ward_location_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WardPositionController {
  late StreamSubscription<WardLocationModel> _stream;

  WardPositionController(BuildContext context) {
    _stream = Supabase.instance.client
        .from('servers')
        .stream(primaryKey: ['id'])
        .map((maps) => maps
            .map((map) => WardLocationModel.fromJson(map))
            .toList()
            .firstWhere((element) => element.toUserId == HiveCRUD().user!.id))
        .listen((event) {

          BlocProvider.of<NavigationBloc>(context).add(ChangeWardLocation(event));
        })..resume();
  }

  void cancel() {
    _stream.cancel();
  }
}
