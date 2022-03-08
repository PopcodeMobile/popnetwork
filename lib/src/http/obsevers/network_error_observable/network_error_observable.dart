import 'dart:async';

import 'package:popwork/src/http/obsevers/network_error_observable/network_error_type.dart';

abstract class NetworkErrorObservable {
  void onNetworkError(NetworkErrorType errorType);
}

class NetworkErrorObserver {
  NetworkErrorObserver._internal() {
    _initStream();
  }

  static final NetworkErrorObserver instance = NetworkErrorObserver._internal();

  final StreamController<NetworkErrorType> _networkStream =
      StreamController<NetworkErrorType>.broadcast();

  final List<NetworkErrorObservable> _listeners = [];

  void addListener({required NetworkErrorObservable listener}) {
    if (_listeners.contains(listener)) {
      return;
    }

    _listeners.add(listener);
  }

  void removeListener({required NetworkErrorObservable listener}) {
    if (_listeners.contains(listener)) {
      _listeners.remove(listener);
    }
  }

  void removeListeners() {
    _listeners.clear();
  }

  void createNotification({NetworkErrorType? errorType}) {
    if (errorType == null || _networkStream.isClosed) {
      return;
    }
    _networkStream.add(errorType);
  }

  void _initStream() {
    _networkStream.stream.listen((final NetworkErrorType errorType) {
      for (final NetworkErrorObservable listener in _listeners) {
        listener.onNetworkError(errorType);
      }
    });
  }

  void dispose() {
    _networkStream.close();
    removeListeners();
  }
}
