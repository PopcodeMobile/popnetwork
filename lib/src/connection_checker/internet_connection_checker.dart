import 'dart:async';

import 'package:pop_network/src/connection_checker/conection_checker.dart';

///Class responsible for validating the internet connection in the package.
abstract class InternetConnectionChecker {
  ///Validation if the application has internet access
  Future<bool> isConnected();

  ///Retry policy when the request is made when the app is not connected to
  ///the internet
  Future<void> handleRetryWhenInternetBack();
}

///Class responsible for validating the internet connection in the package.
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
