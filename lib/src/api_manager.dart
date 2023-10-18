import 'dart:convert';
import 'dart:io';

import 'package:dio/io.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:pop_network/src/i_api_manager.dart';
import 'package:pop_network/src/mock/mock_reply_params.dart';

class ApiManager extends IApiManager {
  ApiManager({
    required String baseUrl,
    int connectTimeout = 30,
    int receiveTimeout = 30,
    Map<String, dynamic>? headers,
    List<Interceptor> interceptors = const [],
    HttpClient Function()? createHttpClient,
    this.loadMockAsset,
  }) {
    if (loadMockAsset != null) {
      _dioAdapter = DioAdapter(dio: this);
      httpClientAdapter = _dioAdapter;
    } else if (createHttpClient != null) {
      final ioHttpClientAdapter = IOHttpClientAdapter();
      ioHttpClientAdapter.createHttpClient = createHttpClient;
      httpClientAdapter = ioHttpClientAdapter;
    }

    options = BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: Duration(seconds: connectTimeout),
      receiveTimeout: Duration(seconds: receiveTimeout),
    );

    this.interceptors.addAll(interceptors);
  }

  /// [loadMockAsset] is a function that returns a [Future<String>] of the
  /// mock file contents.
  final Future<String> Function(String)? loadMockAsset;
  late final DioAdapter _dioAdapter;

  bool get _mockedEnvironment => loadMockAsset != null;

  Options? _getOptionsWithCacheExpiresIn(
    Duration? cacheExpiresIn,
    Options? options,
  ) {
    if (cacheExpiresIn != null) {
      options ??= Options();
      options.extra ??= <String, dynamic>{};
      options.extra!['cacheExpiresIn'] = cacheExpiresIn;
    }
    return options;
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Duration? cacheExpiresIn,
    MockReplyParams? mockReplyParams,
  }) async {
    if (_mockedEnvironment && mockReplyParams != null) {
      _dioAdapter.onGet(path, (req) => _onMockRequest(req, mockReplyParams));
    }
    return super.get(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _getOptionsWithCacheExpiresIn(cacheExpiresIn, options),
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Duration? cacheExpiresIn,
    MockReplyParams? mockReplyParams,
  }) async {
    if (_mockedEnvironment && mockReplyParams != null) {
      _dioAdapter.onPost(path, (req) => _onMockRequest(req, mockReplyParams));
    }
    return super.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _getOptionsWithCacheExpiresIn(cacheExpiresIn, options),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Duration? cacheExpiresIn,
    MockReplyParams? mockReplyParams,
  }) async {
    if (_mockedEnvironment && mockReplyParams != null) {
      _dioAdapter.onPatch(path, (req) => _onMockRequest(req, mockReplyParams));
    }
    return super.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _getOptionsWithCacheExpiresIn(cacheExpiresIn, options),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Duration? cacheExpiresIn,
    MockReplyParams? mockReplyParams,
  }) async {
    if (_mockedEnvironment && mockReplyParams != null) {
      _dioAdapter.onPut(path, (req) => _onMockRequest(req, mockReplyParams));
    }

    return super.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _getOptionsWithCacheExpiresIn(cacheExpiresIn, options),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    Duration? cacheExpiresIn,
    MockReplyParams? mockReplyParams,
  }) async {
    if (_mockedEnvironment && mockReplyParams != null) {
      _dioAdapter.onDelete(path, (req) => _onMockRequest(req, mockReplyParams));
    }
    return super.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _getOptionsWithCacheExpiresIn(cacheExpiresIn, options),
      cancelToken: cancelToken,
    );
  }

  Future<void> _onMockRequest(request, MockReplyParams params) async {
    await request.reply(
      params.status.code,
      json.decode(await loadMockAsset!(params.mockPath)),
      statusMessage: params.status.message,
      delay: params.delay,
    );
  }
}
