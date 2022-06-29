import 'dart:async';

import 'package:pop_network/src/endpoint/endpoint.dart';
import 'package:pop_network/src/http/provider/dio/dio_provider.dart';
import 'package:pop_network/src/http/provider/network_provider.dart';
import 'package:pop_network/src/methods/http_method.dart';
import 'package:pop_network/src/mock/mock_provider.dart';
import 'package:pop_network/src/network.dart';
import 'package:pop_network/src/raw_response_notifier/raw_response_notifiable.dart';
import 'package:pop_network/src/raw_response_notifier/raw_response_notifier.dart';
import 'package:pop_network/src/response/api_result.dart';
import 'package:pop_network/src/response/network_response.dart';
import 'package:pop_network/src/response/states/apiError/api_error.dart';
import 'package:pop_network/src/response/states/internal_error.dart';
import 'package:pop_network/src/response/states/success.dart';

///
///Responsible for initiating the request for your api
///To use it, it is only necessary to call the `.request` function or pass the
///endpoint as a parameter. To learn more about the endpoint settings [click here](https://github.com/PopcodeMobile/popnetwork/blob/main/doc/endpoint.md)
class ApiManager {
  static final NetworkProvider _networkProvider = DioProvider();
  static final RawResponseNotifier _rawResponseNotifier = RawResponseNotifier();

  /// add a class to be notified by the api.
  static void addNotifiable(RawResponseNotifiable listener) {
    _rawResponseNotifier.addListener(listener);
  }

  /// Remove a class to be notified by the api.
  static void removeNotifiable(RawResponseNotifiable listener) {
    _rawResponseNotifier.removeListener(listener);
  }

  /// Sends an internal error to the plugin user.
  static InternalError _makeInternalError() {
    return InternalError(
      message: PopNetwork.defaultErrorMessage,
      statusCode: 520,
    );
  }

  /// Perform the request
  static Future<ApiResult> _request({Endpoint? endpoint}) async {
    final _endpoint = endpoint ?? Endpoint();
    try {
      final NetworkResponse response = await _endpoint.method.request(
        http: _networkProvider,
        endpoint: _endpoint,
      );
      var statusCode = response.status;

      if (statusCode != null && statusCode >= 200 && statusCode < 400) {
        return Future<Success>.value(
          Success(data: response.data, statusCode: statusCode),
        );
      }

      return Future<ApiError>.value(ApiError(
        data: response.data,
        statusCode: statusCode ?? 520,
        path: response.data['path'],
        timestamp: response.data['timestamp'],
      ));
    } catch (_) {
      return _makeInternalError();
    }
  }

  /// Call of the request that will be made to the API with the settings that were passed by the Endpoint (if performed).
  static Future<ApiResult> requestApi({
    Endpoint? endpoint,
    String? namePackage,
    bool? randomError,
  }) {
    if (PopNetwork.isMock) {
      return requestMock(
        endpoint: endpoint,
        namePackage: namePackage,
        randomError: randomError,
      );
    }
    return _request(endpoint: endpoint);
  }

  static Future<ApiResult> requestMock({
    Endpoint? endpoint,
    String? namePackage,
    bool? randomError,
  }) async {
    final mock = MockProvider(
      namePackage: namePackage,
    );
    final NetworkResponse response = await mock.request(
      endpoint: endpoint,
      ramdomMockError: randomError ?? false,
    );
    final statusCode = response.status;

    if (statusCode != null && statusCode >= 200 && statusCode < 400) {
      return Future<Success>.value(
        Success(
          data: response.data,
          statusCode: statusCode,
        ),
      );
    }

    return Future<ApiError>.value(
      ApiError(
        statusCode: statusCode ?? 520,
      ),
    );
  }
}
