import 'package:popwork/src/methods/http_method.dart';
import 'package:popwork/src/mock/mock_strategy.dart';

class Endpoint {
  Endpoint({
    required this.path,
    required this.method,
    this.mockFile,
    this.responseType = ResponseType.json,
    this.parameters,
    this.queryParameters,
    this.headers,
    this.mockStrategy,
    this.timeout,
  });

  final String path;
  final HttpMethod method;
  final String? mockFile;
  final ResponseType responseType;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? parameters;
  final Map<String, dynamic>? queryParameters;
  final MockStrategy? mockStrategy;
  final int? timeout;
}

enum ResponseType { json, plain, bytes, stream }
