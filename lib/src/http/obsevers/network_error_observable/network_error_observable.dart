import 'dart:async';

import 'package:pop_network/src/http/obsevers/network_error_observable/network_error_type.dart';

///Responsible for observing the errors that returned to api.
abstract class NetworkErrorObservable {
  ///Error mapping in the ment that happens. Some function can be performed if necessary after an error occurs in any class that is observing, without creating a dependency with the network layer.
  void onNetworkError(NetworkErrorType errorType);
}

///Singleton responsible for watching networ for error mapping.
class NetworkErrorObserver {
  NetworkErrorObserver._internal() {
    _initStream();
  }

  static final NetworkErrorObserver instance = NetworkErrorObserver._internal();

  final StreamController<NetworkErrorType> _networkStream =
      StreamController<NetworkErrorType>.broadcast();

  final List<NetworkErrorObservable> _listeners = [];

  ///Add the class to be notified when an error happens. It is only necessary to pass the class with `this` and the class must implement the `NetworkErrorObservable` class
  void addListener({required NetworkErrorObservable listener}) {
    if (_listeners.contains(listener)) {
      return;
    }

    _listeners.add(listener);
  }

  ///remove the class to be notified when an error occurs.
  void removeListener({required NetworkErrorObservable listener}) {
    if (_listeners.contains(listener)) {
      _listeners.remove(listener);
    }
  }

  ///Removes all added Listeners.
  void removeListeners() {
    _listeners.clear();
  }

  ///Creates a notification so that it is observing the error mapping.
  void createNotification({NetworkErrorType? errorType}) {
    if (errorType == null || _networkStream.isClosed) {
      return;
    }
    _networkStream.add(errorType);
  }

  ///Init Stream
  void _initStream() {
    _networkStream.stream.listen((final NetworkErrorType errorType) {
      for (final NetworkErrorObservable listener in _listeners) {
        listener.onNetworkError(errorType);
      }
    });
  }

  ///Close Stream and remove Listerners.
  void dispose() {
    _networkStream.close();
    removeListeners();
  }
}
