import 'package:pop_network/src/endpoint/endpoint.dart';
import 'package:pop_network/src/response/network_response.dart';

///Mapping of the types of requests that can be performed.
abstract class NetworkProvider {
  ///Get request.
  Future<NetworkResponse> get({required Endpoint endpoint});

  ///Post request.
  Future<NetworkResponse> post({required Endpoint endpoint});

  ///Put request.
  Future<NetworkResponse> put({required Endpoint endpoint});

  ///Delete request.
  Future<NetworkResponse> delete({required Endpoint endpoint});

  ///Patch request.
  Future<NetworkResponse> patch({required Endpoint endpoint});
}
