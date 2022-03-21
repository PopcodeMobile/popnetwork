<p align="center">
   <img src="https://user-images.githubusercontent.com/66264766/157141908-c8a760f7-6e13-4046-90f6-9243f698062b.png" alt="adaptable" width="500"/>
</p>

# RawResponseNotifier

It is possible to get the response at some points in the application with the `RawResponseNotifier`. Par uses just create a class that implements `RawResponseNotifiable`.

example

```dart
class Notifible implements RawResponseNotifiable{
  Notifible(){
    ApiManager.addNotifiable(this);
  }
  @override
  onResponse(){
    ...
  }
}
```
- `onResponse`: allows receiving data in any class to which the `RawResponse` type listener is added;