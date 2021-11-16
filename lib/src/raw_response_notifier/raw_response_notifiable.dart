import 'package:network/src/raw_response_notifier/raw_response.dart';

abstract class RawResponseNotifiable {
  void onResponse(RawResponse response);
}
