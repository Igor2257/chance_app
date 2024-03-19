import 'dart:async';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionStream {
  StreamSubscription<ConnectivityResult>? onConnectivityChangedStream;
  static bool isUserHaveInternetConnection = true,
      showInternetConnection = false;
  late Connectivity _connectivity;
  late Function(VoidCallback fn) setState;

  InternetConnectionStream(void Function(VoidCallback fn) this.setState) {
    _connectivity = Connectivity();
    onConnectivityChangedStream =
        _connectivity.onConnectivityChanged.listen((result) {
      _checkInternetConnectivity(result: result);
    })
          ..resume();
  }

  Future<void> _checkInternetConnectivity({ConnectivityResult? result}) async {
    var newResult = result ?? await _connectivity.checkConnectivity();

    ///TODO
    if (newResult != ConnectivityResult.none) {
      changeUserHaveInternetConnection(true);
    } else {
      changeUserHaveInternetConnection(false);
    }
  }

  void changeUserHaveInternetConnection(bool value) async {
    setState(() {
      isUserHaveInternetConnection = value;

      showInternetConnection = true;
    });

    if (value) {
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        showInternetConnection = false;
      });
    }
  }

  void pause() {
    onConnectivityChangedStream!.pause();
  }

  void resume() {
    onConnectivityChangedStream!.resume();
  }

  void cancel() {
    onConnectivityChangedStream!.cancel();
  }
}
