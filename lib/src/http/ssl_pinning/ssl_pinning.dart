import 'package:dio/dio.dart';
/// Contract to send the ssl pinning to alter the routes when necessary.
abstract class SSLPinning {
  ///Responsible for applying the certificate that was passed in the initial configuration.
  Future<void> pinningCertificate({
    required HttpClientAdapter httpClientAdapter,
  });
}
