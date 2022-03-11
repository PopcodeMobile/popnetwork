import 'package:pop_network/src/endpoint/endpoint.dart';
import 'package:pop_network/src/http/provider/network_provider.dart';
import 'package:pop_network/src/methods/http_method.dart';
import 'package:pop_network/src/response/network_response.dart';

class Delete implements IHttpMethod {
  @override
  Future<NetworkResponse> request(
      {required NetworkProvider http, required Endpoint endpoint}) {
    return http.delete(endpoint: endpoint);
  }
}
