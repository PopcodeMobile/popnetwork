import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pop_network/pop_network.dart';
import 'package:test/test.dart';

/// Runs the interceptor through the real Dio pipeline, so it also guards
/// against `implements Interceptor` (broken since dio 5.11.0) being introduced
/// here. See `pop_network_log_interceptor_test.dart`.
void main() {
  group('PopCacheInterceptor', () {
    test('registers the request in the cache storage', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://pop.network'));
      final adapter = DioAdapter(dio: dio);
      final cacheRequestData = MemoryCacheRequestData();
      dio.interceptors.add(PopCacheInterceptor(cacheRequestData));
      adapter.onGet('/cached', (server) => server.reply(200, {'ok': true}));

      final response = await dio.get<dynamic>(
        '/cached',
        options: Options(extra: {'cacheExpiresIn': const Duration(minutes: 5)}),
      );

      expect(response.statusCode, 200);
      expect(
        await cacheRequestData.getRequestKey(
          key: RequestCacheKey.fromRequestOptions(response.requestOptions),
        ),
        isNotNull,
      );
    });
  });
}
