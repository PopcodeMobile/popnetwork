import 'dart:math';

import 'package:dio/dio.dart';
import 'package:pop_network/src/connection_checker/internet_connection_checker.dart';
import 'package:pop_network/src/endpoint/endpoint.dart';
import 'package:pop_network/src/http/obsevers/network_error_observable/network_error_observable.dart';
import 'package:pop_network/src/http/obsevers/network_error_observable/network_error_type.dart';
import 'package:pop_network/src/mock/mock_json_file.dart';
import 'package:pop_network/src/response/network_response.dart';
import 'package:pop_network/src/util/query_formatter.dart';

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

  bool _validateMock(Endpoint endpoint) =>
      endpoint.mockStrategy != null ||
      (endpoint.mockName != null && endpoint.mockName!.isNotEmpty);

  Future<NetworkResponse> request({Endpoint? endpoint}) async {
    final _endpoint = endpoint ?? Endpoint();
    final isConnected = await connectionChecker.isConnected();
    if (!isConnected) {
      NetworkErrorObserver.instance
          .createNotification(errorType: NetworkErrorType.noConnection);
      await connectionChecker.handleRetryWhenInternetBack();
    }
    dynamic jsonResponse;
    if (_validateMock(_endpoint)) {
      jsonResponse = await MockJsonFile.getDataFrom(
        endpoint: _endpoint,
      );
    }

    NetworkResponse response;
    final number = Random(1);
    if (_validateMock(_endpoint)) {
      if (number.nextBool()) {
        response = _buildResponseError();
      } else {
        response = _buildResponse(data: jsonResponse);
      }
    } else {
      response = _buildResponseError();
    }

    print(
        '--> MOCK: ${response.status} /${_endpoint.suffixPath}${QueryFormatter.formatQueryParameters(parameters: _endpoint.queryParameters)}');
    print('--> ${response.data}');
    if (response.typeError != null) {
      print('--> ERROR: ${response.typeError}');
    }
    print('--> END MOCK RESPONSE');
    return response;
  }
}
