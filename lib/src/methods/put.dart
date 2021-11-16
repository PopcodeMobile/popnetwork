import 'package:network/src/endpoint/endpoint.dart';
import 'package:network/src/http/provider/network_provider.dart';
import 'package:network/src/methods/http_method.dart';
import 'package:network/src/response/network_response.dart';

class Put implements HttpMethod {
  @override
  Future<NetworkResponse> request(
      {required NetworkProvider http, required Endpoint endpoint}) {
    return http.put(endpoint: endpoint);
  }
}
