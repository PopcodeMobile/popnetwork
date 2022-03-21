import 'package:pop_network/src/raw_response_notifier/raw_response.dart';
import 'package:pop_network/src/raw_response_notifier/raw_response_notifiable.dart';
import 'package:pop_network/src/response/network_response.dart';

/// Class responsible for notifying and storing the classes that are being notified when a certain event happens.
class RawResponseNotifier {
  final List<RawResponseNotifiable> _listeners = [];

  ///Add Listener
  void addListener(RawResponseNotifiable listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  ///Remove Listener
  void removeListener(RawResponseNotifiable listener) {
    if (_listeners.isEmpty) {
      return;
    }

    if (_listeners.contains(listener)) {
      _listeners.remove(listener);
    }
  }

  ///Convert Network Respose To Raw Response
  RawResponse _convertNetworkResposeToRawResponse(NetworkResponse response) {
    return RawResponse(data: response.data, statusCode: response.status ?? 520);
  }

  /// Notifies listeners about a certain action being mapped.
  void notify(NetworkResponse response) {
    final rawResponse = _convertNetworkResposeToRawResponse(response);
    if (hasNotifiables) {
      final copy = [..._listeners];
      for (RawResponseNotifiable notifiable in copy) {
        notifiable.onResponse(rawResponse);
      }
    }
  }

  /// Validates if listeners feel on the list.
  bool get hasNotifiables => _listeners.isNotEmpty;
}
