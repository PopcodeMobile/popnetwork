import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pop_network/pop_network.dart';
import 'package:test/test.dart';

/// Runs the interceptor through the real Dio pipeline, so it also guards
/// against `implements Interceptor` (broken since dio 5.11.0) being introduced
/// here. See `pop_network_log_interceptor_test.dart`.
void main() {
  group('PopErrorInterceptor', () {
    test('resolves a failed call into a Response', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://pop.network'));
      final adapter = DioAdapter(dio: dio);
      dio.interceptors.add(PopErrorInterceptor());
      adapter.onGet('/failure', (server) => server.reply(500, {'error': 'x'}));

      final response = await dio.get<dynamic>('/failure');

      expect(response.statusCode, 500);
      expect(response.data, {'error': 'x'});
    });
  });
}
