import 'package:pop_network/src/methods/http_method.dart';
import 'package:pop_network/src/mock/mock_strategy.dart';

/// Class responsible for additional settings for the route.
/// To modify the request method, just send it to the endpoint
/// ```dart
/// Endpoint(
///   method: HttpMethod.post
/// )
/// ```
/// There are other settings that can be made, follow the example below in more detail:

/// ```dart
/// Endpoint(
///   responseType: ResponseType.bytes,
///   parameters: <String, dynamic>{"key": value},
///   queryParameters: <String, dynamic>{"key": value},
///   headers: <String, dynamic>{"key": value},
///   mockStrategy: MockStrategy(),
///   timeout: 30,
/// )
/// ```
///
/// - `responseType`: type of request that will be returned by the parent;
/// - `parametrs`: request data passed in the route;
/// - `queryParameters`: request data as a parameter in the URL;
/// - `headers`: It is a validator, a unique string identifying the version of the resource.
/// - `mockStrategy`: strategy to vary the rock according to who is using the package. For more information [Mock Guide](https://github.com/PopcodeMobile/popnetwork/blob/main/doc/mock.md);
/// - `timeout`: Time the app will wait for the request response;
class Endpoint {
  Endpoint({
    this.suffixPath = '',
    this.method = HttpMethod.get,
    this.mockName,
    this.responseType = ResponseType.json,
    this.parameters,
    this.queryParameters,
    this.headers,
    this.mockStrategy,
    this.timeout,
  });

  final String suffixPath;
  final HttpMethod method;
  final String? mockName;
  final ResponseType responseType;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? parameters;
  final Map<String, dynamic>? queryParameters;
  final MockStrategy? mockStrategy;
  final int? timeout;
}

enum ResponseType { json, plain, bytes, stream }
