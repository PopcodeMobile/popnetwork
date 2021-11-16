import 'package:network/src/endpoint/endpoint.dart';
import 'package:network/src/http/provider/network_provider.dart';
import 'package:network/src/response/network_response.dart';

abstract class HttpMethod {
  Future<NetworkResponse> request(
      {required NetworkProvider http, required Endpoint endpoint});
}
