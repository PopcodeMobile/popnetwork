import 'package:dio/dio.dart';
import 'package:pop_network/src/response/api_result.dart';

/// Responsible for mapping the internal errors of the network with certain parameters stored.
class InternalError implements ApiResult {
  InternalError({
    required this.statusCode,
    required this.message,
    this.typeError,
  });

  final int statusCode;
  final String message;
  final DioErrorType? typeError;
}
