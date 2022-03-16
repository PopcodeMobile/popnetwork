<p align="center">
   <img src="https://user-images.githubusercontent.com/66264766/157141908-c8a760f7-6e13-4046-90f6-9243f698062b.png" alt="adaptable" width="500"/>
</p>

# MappedApiError

To map the error, it will be necessary to create a class that implements the `MappedApiError<Input, Output>` interface, it will be necessary to inform the types of input and mapping sayings;

example

```dart
class MapCustomError implements MappedApiError<Map, dynamic>(
  @override
  String get messageDefault =>
      'Sorry, there was a problem. Please try again later.';
  @override
  dynamic mappingError(Map data){
    ...
  }
)
```

It is also possible to inform a standard error message, in case the application needs it.

- `mappingError`: responsible for the mapping needed for your application.
- `Input`: input that will be received from the API;
- `Outpit`: Output that will be sent to the application, remembering that it will be displayed according to the customization.

---
## Configuration at startup
<br>
To add custom settings, just pass the edited class calling the initial network configuration.
<br>

example

```dart
void main() {
  Network.config(
    mappedApiError: MapCustomError(),
  )
}

```
---

