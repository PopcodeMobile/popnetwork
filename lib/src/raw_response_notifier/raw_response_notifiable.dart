import 'package:pop_network/src/raw_response_notifier/raw_response.dart';

///It is possible to get the response at some points in the application with the `RawResponseNotifier`. Par uses just create a class that implements `RawResponseNotifiable`.
/// example
/// ```dart
/// class Notifible implements RawResponseNotifiable{
///   Notifible(){
///     ApiManager.addNotifiable(this);
///   }
///   @override
///   onResponse(){
///     ...
///   }
/// }
/// ```
/// - `onResponse`: allows receiving data in any class to which the `RawResponse` type listener is added;
abstract class RawResponseNotifiable {
  /// Function called when notified by the network layer
  void onResponse(RawResponse response);
}
