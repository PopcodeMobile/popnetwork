import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// [PopNetworkLogInterceptor] is used to print logs during network requests.
///
/// It's better to add [PopNetworkLogInterceptor] to the tail of the interceptor queue,
/// otherwise the changes made in the interceptor behind A will not be printed out.
/// This is because the execution of interceptors is in the order of addition.
class PopNetworkLogInterceptor implements Interceptor {
  PopNetworkLogInterceptor({
    this.showRequestHeader = false,
    this.showRequestBody = true,
    this.showRequest = true,
    this.showResponseHeader = false,
    this.showResponseBody = true,
    this.showError = true,
    this.logPrint = print,
  });

  /// [showRequest] indicates if the request [Options.uri] should be logged.
  bool showRequest;

  /// [showRequestHeader] indicates if the request [Options.headers]
  /// should be logged.
  bool showRequestHeader;

  /// [showRequestBody] indicates if the request [Options.data]
  /// should be logged.
  bool showRequestBody;

  /// [showResponseBody] indicates if the response [Response.data]
  /// should be logged.
  bool showResponseBody;

  /// [showResponseHeader] indicates if the response [Response.headers]
  /// should be logged.
  bool showResponseHeader;

  /// [showError] indicates if the error should be logged.
  bool showError;

  /// Log printer; defaults print log to console.
  /// In flutter, you'd better use logPrint.
  /// you can also write log in a file, for example:
  ///```dart
  ///  final file=File("./log.txt");
  ///  final sink=file.openWrite();
  ///  apiManager.interceptors.add(LogInterceptor(logPrint: sink.writeln));
  ///  ...
  ///  await sink.close();
  ///```
  void Function(Object object) logPrint;

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    if (showRequest) {
      logPrint('<-- ERROR [${err.requestOptions.method.toUpperCase()}]'
          ' ${err.requestOptions.uri}');
    }
    if (showError && err.response != null) {
      logPrint(err.response!.formatData);
      logPrint(err.error.toString());
      logPrint('<-- END ${err.requestOptions.method.toUpperCase()}');
    }

    handler.next(err);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (showRequest) {
      logPrint('--> [${options.method.toUpperCase()}] ${options.uri}');
    }
    if (showRequestHeader) {
      logPrint('Headers:');
      options.headers.forEach((key, value) => logPrint('$key: $value'));
    }
    if (showRequestBody && options.data != null) {
      try {
        logPrint(JsonEncoder.withIndent('  ').convert(options.data));
      } catch (e) {
        logPrint('Error serializing request data: ${e.toString()}');
      }
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (showRequest) {
      logPrint(
        '<-- ${response.statusCode} ${response.statusMessage} '
        '[${response.requestOptions.method.toUpperCase()}] '
        '${response.requestOptions.uri}',
      );
    }
    if (showResponseHeader) {
      logPrint('Headers: ${response.headers.toString()}');
    }
    if (showResponseBody) {
      logPrint(response.formatData);
    }

    handler.next(response);
  }
}

extension _ResponseExtension on Response {
  String get _formatTypeBytes {
    final bytes = Uint8List.fromList(data);
    return '--> ${bytes.sublist(0, 5)}... A lot of bytes...';
  }

  String get formatData {
    if (requestOptions.responseType == ResponseType.bytes) {
      return _formatTypeBytes;
    }
    try {
      final jsonFormatado = JsonEncoder.withIndent('  ').convert(data);
      return jsonFormatado.replaceFirst(
        RegExp(r'(?<="video": \[)[^[]+(?=])'),
        '"A lot of bytes..."',
      );
    } catch (e) {
      return 'Error formatting data: ${e.toString()}';
    }
  }
}
