///To map the error, it will be necessary to create a class that implements the `MappedApiError<Input, Output>` interface, it will be necessary to inform the types of input and mapping sayings;
/// exemplo
/// ```dart
/// class MapCustomError implements MappedApiError<Map, dynamic>(
///   @override
///   String get messageDefault =>
///       'Sorry, there was a problem. Please try again later.';
///   @override
///   dynamic mappingError(Map data)
/// )
/// ```
/// It is also possible to inform a standard error message, in case the application needs it.
/// - `mappingError`: responsible for the mapping needed for your application.
/// - `Input`: input that will be received from the API;
/// - `Outpit`: Output that will be sent to the application, remembering that it will be displayed according to the customization.
///

abstract class MappedApiError<Input, Output> {
  ///It is also possible to inform a standard error message, in case the application needs it.
  String get messageDefault;

  ///responsible for the mapping needed for your application.
  Output mappingError(Input data);
}

class MappedApiErrorDefault
    implements MappedApiError<Map<String, dynamic>, MappedApiErrorDefault> {
  MappedApiErrorDefault({
    this.message,
    this.code,
    this.details,
  });

  final String? details;
  final String? message;
  final String? code;

  Map<String, dynamic> toMap() {
    return {
      'details': details,
      'message': message,
      'code': code,
    };
  }

  factory MappedApiErrorDefault.fromMap(Map<String, dynamic> map) {
    return MappedApiErrorDefault(
      details: map['details'],
      message: map['message'],
      code: map['code'],
    );
  }

  @override
  MappedApiErrorDefault mappingError(Map<String, dynamic> data) {
    return MappedApiErrorDefault.fromMap(data);
  }

  @override
  String get messageDefault =>
      'Sorry, there was a problem. Please try again later.';
}
