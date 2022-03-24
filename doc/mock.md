<p align="center">
   <img src="https://user-images.githubusercontent.com/66264766/157141908-c8a760f7-6e13-4046-90f6-9243f698062b.png" alt="adaptable" width="500"/>
</p>

# Mock

In the package it is possible to return mock so that it is possible to validate some information when the application is not connected to the internet;
There are two types of mappings:

- It is possible to map by json.
- It is possible to perform the mapping using a strategy and it is necessary to create a `json` file with the data to be returned.

---
## Configuration and Usage
<br>

the default path that the package will adopt is `assets/api/mock`, but it is possible to customize this path according to the application's needs.
To configure, just:

```dart
void main() {
  PopNetwork.config(
    pathMock: 'assets/api/responses',
  )
}
```

With that the package will always get the mocks in the custom path.

NOTE: It is necessary to set the assets of *pubspec.yaml*.

<br>
<br>

To inform the file that will be returned, it is necessary to pass the *name* through `EndPoit` before making the call with `ApiManeger.requestApi`.
example

```dart
ApiResult getApi() {
  final Endpoint endpoint = Endpoint(
      mockFile: 'mock_name',
    );

    return await ApiManager.requestApi(endpoint: endpoint);
}
```

or

```dart
ApiResult getApi() {
    return await ApiManager.requestApi(endpoint: Endpoint(
      mockFile: 'mock_name',
    ));
}
```


<br>
<br>

It is possible to create a strategy to get your mock files:
```dart
final Endpoint endpoint = Endpoint(
  mockStrategy: MockCustomStrategy(),
);

return await ApiManager.requestApi(
  endpoint: endpoint,
);

class MockCustomStrategy implements MockStrategy {
  @override
  String getNameJsonFile() {
    final int random = Random().nextInt(2);
    switch (random) {
      case 0:
        return 'json_1';
      default:
        return 'json_2';
    }
  }
}
```
It is possible to make the requests directly in the mock used:

```dart
ApiManager.requestMock(EndPoint());
```

---

