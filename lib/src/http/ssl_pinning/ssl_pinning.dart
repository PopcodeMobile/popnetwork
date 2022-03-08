import 'package:dio/dio.dart';

abstract class SSLPinning {
  Future<void> pinningCertificate({
    required HttpClientAdapter httpClientAdapter,
  });
}
