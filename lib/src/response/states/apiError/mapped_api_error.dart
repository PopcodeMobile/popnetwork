abstract class MappedApiError<I, O> {
  String get messageDefault;
  O mappingError(I data);
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
