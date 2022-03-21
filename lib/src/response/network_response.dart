import 'package:dio/dio.dart';
import 'package:pop_network/src/response/api_result.dart';

/// Responsible for mapping the network responses with certain parameters stored.
class NetworkResponse implements ApiResult {
  NetworkResponse({
    this.data,
    this.status,
    this.typeError,
    this.message,
  });

  final dynamic data;
  final int? status;
  final String? message;
  final DioErrorType? typeError;
}
