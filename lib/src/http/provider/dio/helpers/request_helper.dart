import 'package:dio/dio.dart';
import 'package:pop_network/src/endpoint/endpoint.dart';
import 'package:pop_network/src/response/network_response.dart';
///Contract for performing requests to the APIs
abstract class RequestHelper {
  ///Responsible for carrying out the request which was implemented.
  Future<NetworkResponse> makeRequestHelper({
    required Endpoint endpoint,
    required Dio httpProvider,
  });
}
