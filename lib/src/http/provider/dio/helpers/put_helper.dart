import 'package:dio/dio.dart';
import 'package:network/src/endpoint/endpoint.dart';
import 'package:network/src/http/provider/dio/helpers/request_helper.dart';
import 'package:network/src/http/provider/dio/helpers/response_type_dio_helper.dart';
import 'package:network/src/response/network_response.dart';

class PutHelper implements RequestHelper {
  final _contentTypeHelper = ContentTypeDioResponse();

  @override
  Future<NetworkResponse> makeRequestHelper({
    required Endpoint endpoint,
    required Dio httpProvider,
  }) async {
    final Response<dynamic> response = await httpProvider.put<dynamic>(
        endpoint.path,
        data: endpoint.parameters,
        options: Options(
            headers: <String, dynamic>{
              ...httpProvider.options.headers,
              ...endpoint.headers ?? {},
            },
            responseType:
                _contentTypeHelper.getDioResponseType(endpoint.responseType)),
        queryParameters: endpoint.queryParameters);
    return NetworkResponse(
      data: response.data,
      status: response.statusCode,
    );
  }
}
