import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chance_app/ux/hive_crud.dart';
import 'package:chance_app/ux/repository/navigation_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class PositionController {
  StreamSubscription<Position>? positionStream;
  Position? _myPreviousPosition;
  late final Function(VoidCallback fn) _setState;
  static ValueNotifier<Position>? myPosition;
  final List<String> _fakeMessages = [
    'Раз збрехавши, хто тобі повірить?',
    'Хіба порядній людині пристало брехати?',
    'Брехати – значить визнавати перевагу того, кому ви брешете.',
    'Тля їсть траву, ржа – залізо, а брехні – душу.',
    'Найбільший брехун – брехун несвідомий.',
    'Брехня несе душі і тілу нескінченні муки.',
    'Вільний лише той, хто може дозволити собі не брехати.',
    'Хто бреше, той не гідний бути людиною.',
    'Хто хоче брехати з користю, повинен брехати рідко.'
  ];
  late final Timer timer;

  PositionController(void Function(VoidCallback fn) this._setState) {
    Geolocator.getCurrentPosition().then((value) {
      final stream = Geolocator.getPositionStream(
          locationSettings: LocationSettings(
              accuracy: Platform.isAndroid
                  ? LocationAccuracy.high
                  : LocationAccuracy.best,
              distanceFilter: 5));

      positionStream = stream.listen((Position? position) async {
        if (kDebugMode) {
          print("position: $position");
        }
        try {
          if (position != null) {
            if (_myPreviousPosition != null) {
              double distMoved = Geolocator.distanceBetween(
                  position.latitude,
                  position.longitude,
                  _myPreviousPosition!.latitude,
                  _myPreviousPosition!.longitude);
              if (distMoved <= 5) {
                return;
              }
            }
            _setState(() {
              _myPreviousPosition = position;
              if (myPosition != null) {
                myPosition!.value = position;
              } else {
                myPosition = ValueNotifier<Position>(position);
              }
            });
            if (HiveCRUD.instance.setting.isAppShouldSentLocation) {
              await NavigationRepository()
                  .sendMyLocation(position.latitude, position.longitude);
            }
          }
        } catch (e) {
          if (e.toString() == 'isMocked') {
            Random random = Random();
            int randomNumber = random.nextInt(_fakeMessages.length);
            var msg = _fakeMessages[randomNumber];

            Fluttertoast.showToast(msg: msg);
          } else {
            Fluttertoast.showToast(msg: e.toString());
          }
        }
      });

      resume();
      loadTimer();
    });
  }

  Position addFake(Position position) {
    return Position(
      longitude: position.longitude + (Random().nextDouble() * 20),
      latitude: position.latitude + (Random().nextDouble() * 20),
      timestamp: position.timestamp,
      accuracy: position.accuracy,
      altitude: position.altitude,
      heading: position.heading,
      speed: position.speed,
      speedAccuracy: position.speedAccuracy,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
  }

  void resume() {
    positionStream!.resume();
  }

  loadTimer() async {
    timer = Timer.periodic(const Duration(seconds: 60), (timer) async {
      final position = await Geolocator.getCurrentPosition();
      await NavigationRepository()
          .sendMyLocation(position.latitude, position.longitude);
    });
  }
}
