import 'dart:convert';
import 'dart:io';

import 'package:pop_network/pop_network.dart' hide Response;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final address = InternetAddress.loopbackIPv4.address;
  const port = 6969;
  final baseUrl = 'http://${address}:$port';

  Future<HttpServer> createServer(Router router) async {
    return serve(router, address, port);
  }

  group('base cases', () {
    late ApiManager apiManager;
    late HttpServer server;

    setUp(() async {
      apiManager = ApiManager(
        baseUrl: baseUrl,
      );
      server = await createServer(
        Router()
          ..get('/get', (_) => Response.ok('OK'))
          ..post('/post', (_) => Response.ok('OK'))
          ..patch('/patch', (_) => Response.ok('OK'))
          ..put('/put', (_) => Response.ok('OK'))
          ..delete('/delete', (_) => Response.ok('OK')),
      );
    });

    tearDown(() {
      server.close();
    });

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

  group('mocked cases', () {
    const replyParams = const MockReplyParams(mockPath: '/foo/bar/baz.json');
    const data = {'message': 'OK'};

    late ApiManager apiManager;
    late HttpServer server;

    setUp(() async {
      apiManager = ApiManager(
        baseUrl: baseUrl,
        loadMockAsset: (assetPath) async {
          if (assetPath == replyParams.mockPath) {
            return jsonEncode(data);
          }
          throw Exception('Unknown asset $assetPath');
        },
      );
      server = await createServer(
        Router()
          ..get('/get', (_) => Response.ok('OK'))
          ..post('/post', (_) => Response.ok('OK'))
          ..patch('/patch', (_) => Response.ok('OK'))
          ..put('/put', (_) => Response.ok('OK'))
          ..delete('/delete', (_) => Response.ok('OK')),
      );
    });

    tearDown(() {
      server.close();
    });

    test('GET can be mocked', () async {
      final response = await apiManager.get(
        '/get',
        mockReplyParams: replyParams,
      );
      expect(response.data, data);
    });

    test('POST can be mocked', () async {
      final response = await apiManager.post(
        '/post',
        mockReplyParams: replyParams,
      );
      expect(response.data, data);
    });

    test('PATCH can be mocked', () async {
      final response = await apiManager.patch(
        '/patch',
        mockReplyParams: replyParams,
      );
      expect(response.data, data);
    });

    test('PUT can be mocked', () async {
      final response = await apiManager.put(
        '/put',
        mockReplyParams: replyParams,
      );
      expect(response.data, data);
    });

    test('DELETE can be mocked', () async {
      final response = await apiManager.delete(
        '/delete',
        mockReplyParams: replyParams,
      );
      expect(response.data, data);
    });
  });
}
