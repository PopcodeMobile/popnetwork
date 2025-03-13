import 'package:pop_network/src/enums/http_status_enum.dart';
import 'package:pop_network/src/mock/enums/mock_content_type_enum.dart';

/// [MockReplyParams] is used to configure a mock request reply.
class MockReplyParams {
  const MockReplyParams({
    required this.mockPath,
    this.status = HttpStatusEnum.ok,
    this.delay = const Duration(seconds: 1),
    this.contentType = MockContentTypeEnum.json,
  });

  /// [status] is the HTTP status code to return.
  final HttpStatusEnum status;

  /// [mockPath] is the path to the mock file and it must be a json.
  final String mockPath;

  /// [delay] is the delay before returning the mock response.
  final Duration delay;

  /// [contentType] indicates which data format will be sent
  final MockContentTypeEnum contentType;
}
