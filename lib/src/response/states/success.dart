import 'package:pop_network/src/response/api_result.dart';

class Success implements ApiResult {
  Success({
    required this.data,
    required this.statusCode,
  });

  final int statusCode;
  final dynamic data;
}
