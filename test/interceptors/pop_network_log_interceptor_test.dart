import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pop_network/pop_network.dart';
import 'package:test/test.dart';

/// These tests run the interceptor through the real Dio pipeline on purpose.
///
/// Since dio 5.11.0 the pipeline dispatches through private members of
/// [Interceptor] (`_invokeRequest`/`_invokeResponse`/`_invokeError`), so an
/// interceptor declared with `implements Interceptor` still compiles but throws
/// `NoSuchMethodError` at runtime. Asserting on the logged output is what
/// catches it: calling `onRequest`/`onError` directly with fake handlers never
/// reaches the pipeline, and expecting a [DioException] passes even when the
/// interceptor is broken, because Dio wraps the `NoSuchMethodError` into one.
void main() {
  late Dio dio;
  late DioAdapter adapter;
  late List<String> logs;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://pop.network'));
    adapter = DioAdapter(dio: dio);
    logs = <String>[];
    dio.interceptors.add(
      PopNetworkLogInterceptor(
        showRequestHeader: true,
        logPrint: (object) => logs.add(object.toString()),
      ),
    );
  });

  group('PopNetworkLogInterceptor', () {
    test('logs the request and the response of a successful call', () async {
      adapter.onGet('/success', (server) => server.reply(200, {'ok': true}));

      final response = await dio.get<dynamic>('/success');

      expect(response.statusCode, 200);
      expect(logs, contains(contains('--> [GET]')));
      expect(logs, contains(contains('<-- 200')));
    });

    test('logs the error of a failed call', () async {
      adapter.onGet('/failure', (server) => server.reply(500, {'error': 'x'}));

      await expectLater(
        dio.get<dynamic>('/failure'),
        throwsA(isA<DioException>()),
      );

      expect(logs, contains(contains('<-- ERROR [GET]')));
    });
  });
}
