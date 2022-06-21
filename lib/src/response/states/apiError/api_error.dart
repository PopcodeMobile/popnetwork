import 'package:pop_network/pop_network.dart';

class ApiError implements ApiResult {
  ApiError({
    required this.statusCode,
    this.data,
    this.path,
    this.timestamp,
  });

  final int statusCode;
  final String? path;
  final String? timestamp;
  final dynamic data;
}
