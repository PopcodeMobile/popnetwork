<p align="center">
   <img src="https://user-images.githubusercontent.com/66264766/157141908-c8a760f7-6e13-4046-90f6-9243f698062b.png" alt="adaptable" width="500"/>
</p>

# pop_network Config

To configure, it is only necessary that, before the request, the network settings are set.

Each documentation explains how it is serably configured.

Note: it is recommended that the configuration be configured when the application is started.

example

```dart
void main() {
  Network.config(
    baseUrl: 'baseUrl',
    pathMock: 'pathMock',
    headers: {},
    pinning: Pinning(),
    interceptors:[],
    queryParameters: {},
    mappedApiError: MappedApiError(),
    mappedApiError: MappedApiError(),
    mockedEnvironment: false
  )
}
```
- `baseUrl`: base url that will be concatenated in requests
- `pathMock`: file path of [mock]();
- `headers`: it will be possible to inform a fixed headers in the requests;
- `pinning`: a certificate can be passed to requests;
- `interceptors`: it is possible to pass an interceptor to be added to its network layer;
- `queryParameters`: it will be possible to inform a fixed queryParameters in the requisitioners;
- `mappedApiError`: It is possible to create a standard error mapping
- `mockedEnvironment`: Informs if the application requests will be in mock;
---
## Interceptors
<br>

It is possible to create interceptors to perform some functions before and after requests are performed. To refine it just create a class that implements the `Interceptor` that is from [DIO](https://pub.dev/packages/dio);

<br>

example

```dart
class RequestInterceptor extends Interceptor {
  ...
}
void main() {
  void main() {
  PopNetwork.config(
    interceptors: [
      RequestInterceptor(),
    ],
  )
}
}

```
---

