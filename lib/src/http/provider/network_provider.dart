import 'package:popwork/src/endpoint/endpoint.dart';
import 'package:popwork/src/response/network_response.dart';

abstract class NetworkProvider {
  Future<NetworkResponse> get({required Endpoint endpoint});
  Future<NetworkResponse> post({required Endpoint endpoint});
  Future<NetworkResponse> put({required Endpoint endpoint});
  Future<NetworkResponse> delete({required Endpoint endpoint});
  Future<NetworkResponse> patch({required Endpoint endpoint});
}
