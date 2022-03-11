import 'package:pop_network/src/endpoint/endpoint.dart';
import 'package:pop_network/src/http/provider/network_provider.dart';
import 'package:pop_network/src/methods/delete.dart';
import 'package:pop_network/src/methods/get.dart';
import 'package:pop_network/src/methods/patch.dart';
import 'package:pop_network/src/methods/post.dart';
import 'package:pop_network/src/methods/put.dart';
import 'package:pop_network/src/response/network_response.dart';

///The existing methods in `HttpMethod` are *.delete*, *.put*, *.patch*, *.post* and *.get*.
enum HttpMethod {
  get,
  delete,
  patch,
  post,
  put,
}

extension MethodEnumExt on HttpMethod {
  Future<NetworkResponse> request({
    required NetworkProvider http,
    required Endpoint endpoint,
  }) {
    switch (this) {
      case HttpMethod.delete:
        return Delete().request(http: http, endpoint: endpoint);
      case HttpMethod.patch:
        return Patch().request(http: http, endpoint: endpoint);
      case HttpMethod.post:
        return Post().request(http: http, endpoint: endpoint);
      case HttpMethod.put:
        return Put().request(http: http, endpoint: endpoint);
      default:
        return Get().request(http: http, endpoint: endpoint);
    }
  }
}

abstract class IHttpMethod {
  Future<NetworkResponse> request({
    required NetworkProvider http,
    required Endpoint endpoint,
  });
}
