abstract class MappedApiError<T, T2> {
  T mappingError(T2 data);
}

class MappedApiErrorDefault
    implements MappedApiError<MappedApiErrorDefault, Map<String, dynamic>> {
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
}
