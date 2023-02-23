import 'dart:math';

import 'package:dio/dio.dart';
import 'package:pop_network/src/endpoint/endpoint.dart';
import 'package:pop_network/src/mock/mock_json_file.dart';
import 'package:pop_network/src/response/network_response.dart';
import 'package:pop_network/src/util/query_formatter.dart';

/// Responsible for getting the data from the file that are added to mock the features and validate if the app is connected to the internet.
class MockProvider {
  final String? namePackage;

  MockProvider({this.namePackage});
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

  Future<NetworkResponse> request({
    Endpoint? endpoint,
  }) async {
    final _endpoint = endpoint ?? Endpoint();
    dynamic jsonResponse;
    if (_validateMock(_endpoint)) {
      jsonResponse = await MockJsonFile.getDataFrom(
        endpoint: _endpoint,
        namePackage: namePackage,
      );
    }

    NetworkResponse response;
    final number = Random();
    if (_validateMock(_endpoint)) {
      if (number.nextBool() && _endpoint.mockRandomError) {
        response = _buildResponseError();
      } else {
        response = _buildResponse(data: jsonResponse);
      }
    } else {
      response = _buildResponseError(data: _endpoint.mockBodyError);
    }

    print(
        '--> MOCK: ${response.status} ${_endpoint.validSuffixPath}${QueryFormatter.formatQueryParameters(parameters: _endpoint.queryParameters)}');
    print('--> ${response.data}');
    if (response.typeError != null) {
      print('--> ERROR: ${response.typeError}');
    }
    print('--> END MOCK RESPONSE');
    return response;
  }
}
