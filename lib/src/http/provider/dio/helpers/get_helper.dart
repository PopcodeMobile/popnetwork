part of '../../../../network.dart';


class GetHelper implements RequestHelper {
  final _contentTypeHelper = ContentTypeDioResponse();

  @override
  Future<NetworkResponse> makeRequestHelper({
    required Endpoint endpoint,
    required Dio httpProvider,
  }) async {
    final Response<dynamic> response = await httpProvider.get<dynamic>(
      endpoint.suffixPath,
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
    );
    return NetworkResponse(
      data: response.data,
      status: response.statusCode,
    );
  }

  Map<String, String> mapToQueryString(Endpoint endpoint) {
    final query = endpoint.queryParameters;

    if (query != null) {
      final Map<String, String> queryParameters =
          query.map((key, dynamic value) {
        if (value is List) {
          return MapEntry<String, String>(key, value.join(','));
        } else {
          return MapEntry<String, String>(key, '$value');
        }
      });

      return queryParameters;
    }
    return {};
  }
}
