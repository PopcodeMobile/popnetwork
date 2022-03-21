class PoliticaRetry {
  PoliticaRetry({
    required this.url,
    int attempts = 3,
  }) : _attempts = attempts;
  final String url;
  int _attempts;

  int get attempts => _attempts;

  void decrementAttempts() {
    if (_attempts > 0) {
      _attempts--;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PoliticaRetry &&
          runtimeType == other.runtimeType &&
          url == other.url;

  @override
  int get hashCode => url.hashCode;
}
