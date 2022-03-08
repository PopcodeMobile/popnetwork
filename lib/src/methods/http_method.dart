import 'package:popwork/src/endpoint/endpoint.dart';
import 'package:popwork/src/http/provider/network_provider.dart';
import 'package:popwork/src/methods/delete.dart';
import 'package:popwork/src/methods/get.dart';
import 'package:popwork/src/methods/patch.dart';
import 'package:popwork/src/methods/post.dart';
import 'package:popwork/src/methods/put.dart';
import 'package:popwork/src/response/network_response.dart';

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
