import 'dart:async';

import 'package:dio/dio.dart';

import 'package:popnetwork/src/cache/request_cache_key.dart';

abstract class ICacheRequestData {
  void completeRequest({
    required RequestCacheKey key,
    Response<dynamic>? response,
  });

  Future<Response<dynamic>?>? getRequestResponse({
    required RequestCacheKey key,
  });

  void addRequest({required RequestCacheKey key});

  void removeRequest({required RequestCacheKey key});

  RequestCacheKey? getRequestKey({
    required RequestCacheKey key,
  });

  void clearRequestsData();
}
