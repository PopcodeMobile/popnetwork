import 'package:dio/dio.dart' as dio_response_type show ResponseType;
import 'package:network/src/endpoint/endpoint.dart';

class ContentTypeDioResponse {
  final Map<ResponseType, dio_response_type.ResponseType> _map = {
    ResponseType.json: dio_response_type.ResponseType.json,
    ResponseType.plain: dio_response_type.ResponseType.plain,
    ResponseType.bytes: dio_response_type.ResponseType.bytes,
    ResponseType.stream: dio_response_type.ResponseType.stream
  };

  dio_response_type.ResponseType? getDioResponseType(
      ResponseType responseType) {
    return _map[responseType];
  }
}
