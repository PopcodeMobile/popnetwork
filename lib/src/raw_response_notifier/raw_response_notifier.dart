import 'package:network/src/raw_response_notifier/raw_response.dart';
import 'package:network/src/raw_response_notifier/raw_response_notifiable.dart';
import 'package:network/src/response/network_response.dart';

class RawResponseNotifier {
  final List<RawResponseNotifiable> _listeners = [];

  void addListener(RawResponseNotifiable listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(RawResponseNotifiable listener) {
    if (_listeners.isEmpty) {
      return;
    }

    if (_listeners.contains(listener)) {
      _listeners.remove(listener);
    }
  }

  RawResponse _convertNetworkResposeToRawResponse(NetworkResponse response) {
    return RawResponse(data: response.data, statusCode: response.status ?? 520);
  }

  void notify(NetworkResponse response) {
    final rawResponse = _convertNetworkResposeToRawResponse(response);
    if (hasNotifiables) {
      final copy = [..._listeners];
      for (RawResponseNotifiable notifiable in copy) {
        notifiable.onResponse(rawResponse);
      }
    }
  }

  bool get hasNotifiables => _listeners.isNotEmpty;
}
