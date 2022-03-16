import 'dart:async';

import 'package:pop_network/src/connection_checker/conection_checker.dart';

abstract class InternetConnectionChecker {
  Future<bool> isConnected();

  Future<void> handleRetryWhenInternetBack();
}

class InternetConnectionCheckerImpl implements InternetConnectionChecker {
  @override
  Future<bool> isConnected() async {
    return await ConnectionChecker.isConnectedToInternet();
  }

  @override
  Future<void> handleRetryWhenInternetBack() {
    final responseCompleter = Completer<void>();

    return responseCompleter.future;
  }
}
