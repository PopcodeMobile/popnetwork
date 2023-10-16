import 'package:dio/dio.dart';

/// [RequestCacheKey] is a class that represents the key of a request in the cache.
class RequestCacheKey {
  const RequestCacheKey._({
    required this.path,
    required this.method,
    this.data,
    this.queryParameters,
    this.cacheExpirationDate,
  });

  factory RequestCacheKey.fromRequestOptions(RequestOptions options) =>
      RequestCacheKey._(
        path: options.path,
        data: options.data,
        queryParameters: options.queryParameters,
        method: options.method,
        cacheExpirationDate: options.extra['cacheExpiresIn'] != null
            ? DateTime.now().add(options.extra['cacheExpiresIn'])
            : null,
      );

  factory RequestCacheKey.fromJson(Map<String, dynamic> json) {
    return RequestCacheKey._(
      path: json['path'] as String,
      data: json['data'],
      queryParameters: json['queryParameters'] as Map<String, dynamic>?,
      method: json['method'] as String,
      cacheExpirationDate: json['cacheExpirationDate'] != null
          ? DateTime.parse(json['cacheExpirationDate'] as String)
          : null,
    );
  }

  final String path;
  final dynamic data;
  final String method;
  final Map<String, dynamic>? queryParameters;
  final DateTime? cacheExpirationDate;

  bool get isCacheExpired =>
      cacheExpirationDate?.isBefore(DateTime.now()) ?? true;

  @override
  bool operator ==(covariant RequestCacheKey other) =>
      identical(this, other) ||
      (other.path == path &&
          other.method == method &&
          other.data == data &&
          other.queryParameters == queryParameters);

  @override
  int get hashCode => path.hashCode ^ method.hashCode;

  Map<String, dynamic> get toJson => {
        'path': path,
        'method': method,
        'data': data,
        'queryParameters': queryParameters,
        'cacheExpirationDate': cacheExpirationDate?.toIso8601String(),
      };
}
