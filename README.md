# Popnetwork

The `pop_network` library is an extension of the Dio HTTP client, designed to simplify HTTP requests and assist developers in making efficient use of REST APIs. It includes support for mocking responses using the `http_mock_adapter` library.

## Installation

Add the `pop_network` package to your `pubspec.yaml` file:

```yaml
dependencies:
  pop_network: ^1.2.2
```

Then run pub get to install the package.

> Requires Dio `^5.8.0+1`. Versions up to `1.2.1` are **not** compatible with Dio `5.11.0` or newer — see [Custom Interceptors](#custom-interceptors).

## Getting Started

### Simple Usage

To get started with `pop_network`, create an instance of `ApiManager` with your desired configuration. Here's an example of a simple GET request:

```dart
import 'package:pop_network/pop_network.dart';

final _apiManager = ApiManager(
  baseUrl: 'https://jsonplaceholder.typicode.com',
);

void getTodo() async {
  final response = await _apiManager.get('/todos/1');
  print(response);
}
```

### Mocking Responses

You can also use `pop_network` to mock responses for testing or development purposes. Provide a `loadMockAsset` function and use `MockReplyParams` to configure mock responses:

```dart
final _apiManager = ApiManager(
  baseUrl: 'https://jsonplaceholder.typicode.com',
  loadMockAsset: rootBundle.loadString, // default root folder for Flutter
);

await _apiManager.get(
  '/todos/1',
  mockReplyParams: MockReplyParams(
    mockPath: 'todo_example',
    delay: const Duration(seconds: 1),
    status: HttpStatusEnum.ok,
  ),
);
```

### Logging
`pop_network` provides built-in logging support. You can configure it like this:

```dart
final _apiManager = ApiManager(
  baseUrl: 'https://jsonplaceholder.typicode.com',
  interceptors: [
    PopNetworkLogInterceptor(
      logPrint: (str) => developer.log(str.toString(), name: 'TODO_LOG'),
    ),
  ],
);
```

### Caching Requests with `PopCacheInterceptor`

The package includes a caching mechanism that allows you to cache HTTP responses for a specified duration. This feature is made possible with the `PopCacheInterceptor` and `ICacheRequestData` classes.

Create an instance of `MemoryCacheRequestData`, this class manages the cache storage in memory using a Map, or your own implementation of `ICacheRequestData` and use it to create an instance of `PopCacheInterceptor`.

```dart
final apiManager = ApiManager(
  baseUrl: 'https://jsonplaceholder.typicode.com',
  interceptors: [
    PopCacheInterceptor(MemoryCacheRequestData()),
  ],
);
```

#### Using Cache in Requests

To enable caching for a specific request, you need to provide the cacheExpiresIn parameter in the request. This parameter specifies how long the response should be cached. Here's an example of using cache with a GET request:

```dart
final response = await apiManager.get(
  '/todos',
  cacheExpiresIn: Duration(minutes: 15), // Cache the response for 15 minutes
);
print(response.data);
```

### Custom Interceptors

Besides the interceptors shipped with this package, `ApiManager` accepts any Dio `Interceptor` through the `interceptors` parameter. Always declare it with `extends Interceptor`, never `implements Interceptor`:

```dart
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.token);

  final String token;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }
}
```

Since Dio 5.11.0 the request pipeline dispatches through private members of `Interceptor` (`_invokeRequest`/`_invokeResponse`/`_invokeError`), which cannot be inherited through `implements`. An interceptor declared with `implements` still compiles, but every request fails at runtime with `NoSuchMethodError: ... has no instance method '_invokeError'`.

Interceptors run in the order they are added, so `PopNetworkLogInterceptor` is always moved to the tail of the queue by `ApiManager` — that way it prints whatever the other interceptors changed.

## Issues and Contributions

If you encounter any issues or would like to contribute to this library, please visit the [GitHub repository](https://github.com/PopcodeMobile/popnetwork).

Before opening a pull request, run the checks the pre-commit hook performs, plus the test suite:

```bash
dart format . --set-exit-if-changed
dart analyze
dart test
```
