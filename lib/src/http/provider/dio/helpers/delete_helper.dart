part of '../../../../network.dart';

///Delete request.

class DeleteHelper implements RequestHelper {
  final _contentTypeHelper = ContentTypeDioResponse();

  @override
  Future<NetworkResponse> makeRequestHelper({
    required Endpoint endpoint,
    required Dio httpProvider,
  }) async {
    final Response<dynamic> response = await httpProvider.delete<dynamic>(
      endpoint.validSuffixPath,
      data: endpoint.parameters,
      queryParameters: <String, dynamic>{
        ...PopNetwork._instance.queryParameters.parseQueryParameters(),
        ...endpoint.queryParameters.parseQueryParameters(),
      },
      options: Options(
        headers: <String, dynamic>{
          ...httpProvider.options.headers,
          ...endpoint.headers ?? {},
        },
        responseType:
            _contentTypeHelper.getDioResponseType(endpoint.responseType),
      ),
    );
    return NetworkResponse(
      data: response.data,
      status: response.statusCode,
    );
  }
}
