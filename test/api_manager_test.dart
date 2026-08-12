import 'package:pop_network/pop_network.dart';
import 'package:test/test.dart';

void main() {
  group('ApiManager', () {
    test('keeps PopNetworkLogInterceptor as the last interceptor', () {
      final apiManager = ApiManager(
        baseUrl: 'https://pop.network',
        interceptors: [
          PopNetworkLogInterceptor(logPrint: (_) {}),
          PopErrorInterceptor(),
        ],
      );

      expect(apiManager.interceptors.last, isA<PopNetworkLogInterceptor>());
    });
  });
}
