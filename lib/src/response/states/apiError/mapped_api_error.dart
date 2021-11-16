class MappedApiError {
  MappedApiError({
    this.message,
    this.code,
    this.details,
  });

  factory MappedApiError.fromJson(Map<String, dynamic> json) {
    return MappedApiError(
      message: json['message'],
      code: json['code'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('message', message);
    writeNotNull('details', details);
    writeNotNull('code', code);
    return val;
  }

  final String? details;
  final String? message;
  final String? code;
}
