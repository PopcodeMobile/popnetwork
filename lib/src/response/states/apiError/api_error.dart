import 'package:popwork/src/response/api_result.dart';
import 'package:popwork/src/response/states/apiError/mapped_api_error.dart';

class ApiError implements ApiResult {
  ApiError({
    required this.statusCode,
    required this.error,
    this.path,
    this.timestamp,
  });

  final int statusCode;
  final String? path;
  final String? timestamp;
  final MappedApiError error;
}
