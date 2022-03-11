import 'package:dio/dio.dart';
import 'package:pop_network/src/endpoint/endpoint.dart';
import 'package:pop_network/src/response/network_response.dart';

abstract class RequestHelper {
  Future<NetworkResponse> makeRequestHelper({
    required Endpoint endpoint,
    required Dio httpProvider,
  });
}
