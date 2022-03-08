import 'package:dio/dio.dart';
import 'package:popwork/src/response/api_result.dart';

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
