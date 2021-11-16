import 'package:dio/dio.dart';

class NetworkResponse {
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
