<p align="center">
   <img src="https://user-images.githubusercontent.com/66264766/157141908-c8a760f7-6e13-4046-90f6-9243f698062b.png" alt="adaptable" width="500"/>
</p>

# Endpoint

Some information can be passed to configure the routes before they are called. A common configuration and method change which in robust applications will occur frequently.


example

```dart
Endpoint(
	method: HttpMethod.post
)
```

The existing methods in `HttpMethod` are *.delete*, *.put*, *.patch*, *.post* and *.get*.
*Note*: `.get` is sent by default if not sent when creating the endpoint

<br>

It is possible to add a route that will be concatenated with its base route in each request, it is not necessary to put a slash at the beginning of the suffixPath.

```dart
Endpoint(
	suffixPath: 'path/custom'
)
```
Or you can pass the full route in each request as needed.
```dart
Endpoint(
	suffixPath: 'https://api.example.ht'
)
```
<br>

---
## Other settings.
---
<br>
There are other settings that can be made, follow the example below in more detail:

<br>

```dart
Endpoint(
  responseType: ResponseType.bytes,
  parameters: <String, dynamic>{"key": value},
  queryParameters: <String, dynamic>{"key": value},
  headers: <String, dynamic>{"key": value},
  mockStrategy: MockStrategy(),
  timeout: 30,
)
```
- `responseType`: type of request that will be returned by the parent;
- `parametrs`: request data passed in the route;
- `queryParameters`: request data as a parameter in the URL;
- `headers`: It is a validator, a unique string identifying the version of the resource.
- `mockStrategy`: strategy to vary the rock according to who is using the package. For more information [Mock Guide](https://github.com/isthaynny/pop_network/blob/main/docs/mock.md);
- `timeout`: Time the app will wait for the request response;
