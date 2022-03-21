import 'dart:async';
import 'dart:io';

/// Class responsible for validating the internet connection.
class ConnectionChecker {
  /// Static method to check if it's connected to internet
  /// lookUpAddress: String to use as lookup address to check internet connection
  static Future<bool> isConnectedToInternet({String? lookUpAddress}) async {
    try {
      if (lookUpAddress == null) {
        lookUpAddress = 'www.google.com';
      }
      final result = await InternetAddress.lookup(lookUpAddress);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Constructor to return the same instance for every new initialization
  factory ConnectionChecker() => _instance;

  /// Private instance for current class
  static final ConnectionChecker _instance = ConnectionChecker._();

  /// Factory to init the class constructor
  ConnectionChecker._();
}
