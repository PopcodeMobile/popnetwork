import 'package:dio/dio.dart';
import 'package:popwork/src/endpoint/endpoint.dart';
import 'package:popwork/src/response/network_response.dart';

abstract class RequestHelper {
  Future<NetworkResponse> makeRequestHelper({
    required Endpoint endpoint,
    required Dio httpProvider,
  });
}
