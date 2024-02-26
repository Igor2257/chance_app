import 'dart:async';
import 'dart:ui';

import 'package:chance_app/ux/repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionStream {
  StreamSubscription<ConnectivityResult>? onConnectivityChangedStream;
  static bool isUserHaveInternetConnection = true,
      showInternetConnection = false,
      isUserHaveOfflineData = false;
  late Connectivity _connectivity;
  late Function(VoidCallback fn) setState;

  InternetConnectionStream(void Function(VoidCallback fn) this.setState) {
    _connectivity = Connectivity();
    onConnectivityChangedStream =
        _connectivity.onConnectivityChanged.listen((result) {
      _checkInternetConnectivity(result: result);
    });
  }

  Future<void> _checkInternetConnectivity({ConnectivityResult? result}) async {
    var newResult = result ?? await _connectivity.checkConnectivity();
    bool value = Repository().checkIsAnyTasksNotSent();
    if (newResult != ConnectivityResult.none) {
      changeUserHaveInternetConnection(true);
      if (value) {
        addMessageThatUserHaveOfflineData();
      }
    } else {
      changeUserHaveInternetConnection(false);
    }
  }

  void addMessageThatUserHaveOfflineData() {
    setState(() {
      isUserHaveOfflineData = true;
    });
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

  void changeUserOfflineData(bool value) {
    isUserHaveOfflineData = value;
    setState(() {});
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
