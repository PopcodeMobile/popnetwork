part of '../../../creators/dio_creator.dart';

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
      queryParameters: <String, dynamic>{
        ...DioCreator._instance.queryParameters.parseQueryParameters(),
        ...endpoint.queryParameters.parseQueryParameters(),
      },
    );
    return NetworkResponse(
      data: response.data,
      status: response.statusCode,
    );
  }
}
