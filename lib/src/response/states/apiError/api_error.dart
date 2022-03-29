import 'package:pop_network/src/response/api_result.dart';
import 'package:pop_network/src/response/states/apiError/mapped_api_error.dart';

class ApiError implements ApiResult {
  ApiError({
    required this.statusCode,
    this.error,
    this.path,
    this.timestamp,
  });

  final int statusCode;
  final String? path;
  final String? timestamp;
  final MappedApiError? error;
}
