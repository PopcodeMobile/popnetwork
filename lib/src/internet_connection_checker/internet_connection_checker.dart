import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class InternetConnectionChecker {
  Future<bool> isConnected();

  Future<void> handleRetryWhenInternetBack();
}

class InternetConnectionCheckerImpl implements InternetConnectionChecker {
  @override
  Future<bool> isConnected() async {
    final Connectivity _connectivity = Connectivity();
    final result = await _connectivity.checkConnectivity();

    return result != ConnectivityResult.bluetooth &&
        result != ConnectivityResult.none;
  }

  @override
  Future<void> handleRetryWhenInternetBack() {
    final responseCompleter = Completer<void>();

    return responseCompleter.future;
  }
}
