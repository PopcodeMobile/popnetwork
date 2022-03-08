import 'package:popwork/src/endpoint/endpoint.dart';
import 'package:popwork/src/http/provider/network_provider.dart';
import 'package:popwork/src/response/network_response.dart';

abstract class HttpMethod {
  Future<NetworkResponse> request(
      {required NetworkProvider http, required Endpoint endpoint});
}
