import 'package:dio/dio.dart';

extension ResponseExtension on Response {
  bool get isSuccessful =>
      statusCode != null && statusCode! >= 200 && statusCode! <= 304;

  bool get isError => statusCode == null || statusCode! >= 400;
}
