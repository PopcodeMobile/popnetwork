import 'dart:async';

import 'package:data_connection_checker_tv/data_connection_checker.dart';

abstract class InternetConnectionChecker {
  Future<bool> isConnected();

  Future<void> handleRetryWhenInternetBack();
}

class InternetConnectionCheckerImpl implements InternetConnectionChecker {
  @override
  Future<bool> isConnected() async {
    final dataConnectionChecker = DataConnectionChecker();

    return await dataConnectionChecker.hasConnection;
  }

  @override
  Future<void> handleRetryWhenInternetBack() {
    final responseCompleter = Completer<void>();

    return responseCompleter.future;
  }
}
