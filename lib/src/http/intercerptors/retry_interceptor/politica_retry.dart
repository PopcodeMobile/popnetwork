class PoliticaRetry {
  PoliticaRetry({
    required this.url,
    int tentativas = 3,
  }) : _tentativas = tentativas;
  final String url;
  int _tentativas;

  int get tentativas => _tentativas;

  void decrementarTentativas() {
    if (_tentativas > 0) {
      _tentativas--;
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
