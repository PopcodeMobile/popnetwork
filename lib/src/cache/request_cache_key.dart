import 'package:dio/dio.dart';

/// [RequestCacheKey] is a class that represents the key of a request in the cache.
class RequestCacheKey {
  const RequestCacheKey._({
    required this.path,
    required this.method,
    this.cacheExpirationDate,
  });

  factory RequestCacheKey.fromRequestOptions(RequestOptions options) =>
      RequestCacheKey._(
        path: options.path,
        method: options.method,
        cacheExpirationDate: options.extra['cacheExpiresIn'] != null
            ? DateTime.now().add(options.extra['cacheExpiresIn'])
            : null,
      );

  final String path;
  final String method;
  final DateTime? cacheExpirationDate;

  bool get isCacheExpired =>
      cacheExpirationDate?.isBefore(DateTime.now()) ?? true;

  @override
  bool operator ==(covariant RequestCacheKey other) =>
      identical(this, other) || (other.path == path && other.method == method);

  @override
  int get hashCode => path.hashCode ^ method.hashCode;
}
