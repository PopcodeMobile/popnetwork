# Popnetwork

The `popnetwork` library is an extension of the Dio HTTP client, designed to simplify HTTP requests and assist developers in making efficient use of REST APIs. It includes support for mocking responses using the `http_mock_adapter` library.

## Installation

Add the `popnetwork` package to your `pubspec.yaml` file:

```yaml
dependencies:
  popnetwork: ^2.0.0
```

Then run pub get to install the package.

## Getting Started

### Simple Usage

To get started with popnetwork, create an instance of ApiManager with your desired configuration. Here's an example of a simple GET request:

```dart
import 'package:popnetwork/popnetwork.dart';

final _apiManager = ApiManager(
  baseUrl: 'https://jsonplaceholder.typicode.com',
);

void getUser() async {
  final response = await _apiManager.get('/todos/1');
  print(response);
}
```

### Mocking Responses

You can also use `popnetwork` to mock responses for testing or development purposes. Provide a `loadMockAsset` function and use `MockReplyParams` to configure mock responses:

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
`popnetwork` provides built-in logging support. You can configure it like this:

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

## Issues and Contributions

If you encounter any issues or would like to contribute to this library, please visit the [GitHub repository](https://github.com/PopcodeMobile/popnetwork).
