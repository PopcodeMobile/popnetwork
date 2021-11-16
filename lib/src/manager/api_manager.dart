import 'dart:async';

import 'package:network/src/endpoint/endpoint.dart';
import 'package:network/src/http/provider/dio/dio_provider.dart';
import 'package:network/src/http/provider/network_provider.dart';
import 'package:network/src/raw_response_notifier/raw_response_notifiable.dart';
import 'package:network/src/raw_response_notifier/raw_response_notifier.dart';
import 'package:network/src/response/api_result.dart';
import 'package:network/src/response/network_response.dart';
import 'package:network/src/response/states/apiError/api_error.dart';
import 'package:network/src/response/states/apiError/mapped_api_error.dart';
import 'package:network/src/response/states/internal_error.dart';
import 'package:network/src/response/states/success.dart';

class ApiManager {
  static final NetworkProvider _networkProvider = DioProvider();
  static final RawResponseNotifier _rawResponseNotifier = RawResponseNotifier();

  static void addNotifiable(RawResponseNotifiable listener) {
    _rawResponseNotifier.addListener(listener);
  }

  static void removeNotifiable(RawResponseNotifiable listener) {
    _rawResponseNotifier.removeListener(listener);
  }

  static InternalError _makeInternalError() {
    return InternalError(
      message:
          'Desculpe, tivemos um problema. Por favor, tente novamente mais tarde.',
      statusCode: 520,
    );
  }

  static Future<ApiResult> request({required Endpoint endpoint}) async {
    try {
      final NetworkResponse response = await endpoint.method.request(
        http: _networkProvider,
        endpoint: endpoint,
      );
      var statusCode = response.status;

      if (statusCode != null && statusCode >= 200 && statusCode < 400) {
        return Future<Success>.value(
          Success(data: response.data, statusCode: statusCode),
        );
      }

      _rawResponseNotifier.notify(response);
      final List listErrors = response.data['errors'];
      final List<MappedApiError> mappedErrors = List<MappedApiError>.generate(
        listErrors.length,
        (index) => MappedApiError.fromJson(
          listErrors[index],
        ),
      );
      return Future<ApiError>.value(ApiError(
        error: mappedErrors.first,
        statusCode: statusCode ?? 520,
        path: response.data['path'],
        timestamp: response.data['timestamp'],
      ));
    } catch (_) {
      return _makeInternalError();
    }
  }
}