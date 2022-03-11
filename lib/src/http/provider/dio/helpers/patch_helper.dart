part of '../../../../network.dart';

class PatchHelper implements RequestHelper {
  final _contentTypeHelper = ContentTypeDioResponse();

  @override
  Future<NetworkResponse> makeRequestHelper({
    required Endpoint endpoint,
    required Dio httpProvider,
  }) async {
    final Response<dynamic> response =
        await httpProvider.patch<dynamic>(endpoint.suffixPath,
            queryParameters: <String, dynamic>{
              ...Network._instance.queryParameters.parseQueryParameters(),
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
            data: endpoint.parameters);
    return NetworkResponse(
      data: response.data,
      status: response.statusCode,
    );
  }
}
