import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class PositionController {
  StreamSubscription<Position>? positionStream;
  Position? _myPreviousPosition;
  late Function(VoidCallback fn) setState;
  static ValueNotifier<Position>? myPosition;
  final List<String> fakeMessages = [
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

  PositionController(void Function(VoidCallback fn) this.setState) {
    positionStream = Geolocator.getPositionStream(
            locationSettings: LocationSettings(
                accuracy: Platform.isAndroid
                    ? LocationAccuracy.high
                    : LocationAccuracy.best,
                distanceFilter: 5))
        .listen((Position? position) async {
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

          setState(() {
            _myPreviousPosition = position;
            if (myPosition != null) {
              myPosition!.value=position;
            } else {
              myPosition = ValueNotifier<Position>(position);
            }
          });
        }
      } catch (e) {
        if (e.toString() == 'isMocked') {
          Random random = Random();
          int randomNumber = random.nextInt(fakeMessages.length);
          var msg = fakeMessages[randomNumber];

          Fluttertoast.showToast(msg: msg);
        } else {
          Fluttertoast.showToast(msg: e.toString());
        }
      }
    })
      ..resume();
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

  void paused() {
    positionStream!.pause();
  }

  void resume() {
    positionStream!.resume();
  }

  void cancel() {
    positionStream!.cancel();
  }
}
