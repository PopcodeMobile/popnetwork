import 'dart:io';

import 'package:pop_network/pop_network.dart' hide Response;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test/test.dart';

Future<void> main() async {
  late HttpServer server;
  late ApiManager apiManager;

  final address = InternetAddress.loopbackIPv4.address;
  const port = 6969;
  final baseUrl = 'http://${address}:$port';

  setUp(() async {
    server = await createServer(
      address: address,
      port: port,
    );
    apiManager = ApiManager(
      baseUrl: baseUrl,
    );
  });

  tearDown(() async {
    await server.close();
  });

  group('base cases', () {
    test('GET works', () async {
      final response = await apiManager.get('/get');
      expect(response.data, 'OK');
    });

    test('POST works', () async {
      final response = await apiManager.post('/post');
      expect(response.data, 'OK');
    });

    test('PATCH works', () async {
      final response = await apiManager.patch('/patch');
      expect(response.data, 'OK');
    });

    test('PUT works', () async {
      final response = await apiManager.put('/put');
      expect(response.data, 'OK');
    });

    test('DELETE works', () async {
      final response = await apiManager.delete('/delete');
      expect(response.data, 'OK');
    });

    test('download works', () async {
      final fileName = 'data.json';
      final filePath = '${Directory.systemTemp}/$fileName';
      await apiManager.download('/get', filePath);
      expect(File(filePath).exists(), completion(true));
      expect(File(filePath).readAsString(), completion('OK'));
    });
  });
}

Future<HttpServer> createServer({
  required String address,
  required int port,
}) async {
  final router = Router();
  router.get('/get', (_) => Response.ok('OK'));
  router.post('/post', (_) => Response.ok('OK'));
  router.patch('/patch', (_) => Response.ok('OK'));
  router.put('/put', (_) => Response.ok('OK'));
  router.delete('/delete', (_) => Response.ok('OK'));
  return serve(router, address, port);
}
