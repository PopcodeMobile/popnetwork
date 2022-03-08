import 'package:popwork/src/endpoint/endpoint.dart';
import 'package:popwork/src/http/provider/network_provider.dart';
import 'package:popwork/src/methods/http_method.dart';
import 'package:popwork/src/response/network_response.dart';

class Delete implements HttpMethod {
  @override
  Future<NetworkResponse> request(
      {required NetworkProvider http, required Endpoint endpoint}) {
    return http.delete(endpoint: endpoint);
  }
}
