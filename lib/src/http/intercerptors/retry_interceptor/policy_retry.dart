///Application of the retry policy in the app
class PolicyRetry {
  PolicyRetry({
    required this.url,
    int attempts = 3,
  }) : _attempts = attempts;
  final String url;
  int _attempts;

  ///Number of attempts that the network will try to make the request
  int get attempts => _attempts;

  ///Responsible for decreasing the number of attempts when an attempt is made.
  void decrementAttempts() {
    if (_attempts > 0) {
      _attempts--;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PolicyRetry &&
          runtimeType == other.runtimeType &&
          url == other.url;

  @override
  int get hashCode => url.hashCode;
}
