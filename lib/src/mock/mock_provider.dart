import 'dart:math';

import 'package:dio/dio.dart';
import 'package:popwork/src/endpoint/endpoint.dart';
import 'package:popwork/src/http/obsevers/network_error_observable/network_error_observable.dart';
import 'package:popwork/src/http/obsevers/network_error_observable/network_error_type.dart';
import 'package:popwork/src/internet_connection_checker/internet_connection_checker.dart';
import 'package:popwork/src/mock/mock_json_file.dart';
import 'package:popwork/src/response/network_response.dart';
import 'package:popwork/src/util/query_formatter.dart';

class MockProvider {
  InternetConnectionCheckerImpl connectionChecker =
      InternetConnectionCheckerImpl();
  NetworkResponse _buildResponse({
    required dynamic data,
  }) =>
      NetworkResponse(
        data: data,
        status: 200,
      );

  NetworkResponse _buildResponseError({
    Map<String, dynamic>? data,
  }) =>
      NetworkResponse(
        data: data,
        status: 400,
        typeError: DioErrorType.response,
      );

  Future<NetworkResponse> request({required Endpoint endpoint}) async {
    final isConnected = await connectionChecker.isConnected();
    if (!isConnected) {
      NetworkErrorObserver.instance
          .createNotification(errorType: NetworkErrorType.noConnection);
      await connectionChecker.handleRetryWhenInternetBack();
    }

    final dynamic jsonResponse = await MockJsonFile.getDataFrom(
      endpoint: endpoint,
    );

    NetworkResponse response;
    final number = Random(1);
    if (number.nextBool()) {
      response = _buildResponseError();
    } else {
      response = _buildResponse(data: jsonResponse);
    }
    print(
        '--> MOCK: ${response.status} /${endpoint.suffixPath}${QueryFormatter.formatQueryParameters(parameters: endpoint.queryParameters)}');
    print('--> ${response.data}');
    if (response.typeError != null) {
      print('--> ERROR: ${response.typeError}');
    }
    print('--> END MOCK RESPONSE');
    return response;
  }
}
