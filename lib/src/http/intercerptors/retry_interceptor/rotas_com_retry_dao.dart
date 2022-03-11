import 'package:pop_network/src/http/intercerptors/retry_interceptor/i_rotas_com_retry.dart';
import 'package:pop_network/src/http/intercerptors/retry_interceptor/politica_retry.dart';

class RotasComRetryDAO implements IRotasComRetry {
  RotasComRetryDAO._();

  static final RotasComRetryDAO _instance = RotasComRetryDAO._();

  static RotasComRetryDAO get instance => _instance;

  final Set<PoliticaRetry> _politicas = {};

  @override
  bool get isVazio => _politicas.isEmpty;

  @override
  int get quantidade => _politicas.length;

  void adicionarPoliticaRetry(PoliticaRetry politicaRetry) {
    if (!_politicas.contains(politicaRetry)) {
      _politicas.add(politicaRetry);
    }
  }

  void adicionarMultiplasPoliticasRetry(List<PoliticaRetry> politicasRetry) {
    final politicasNaoExistentes =
        politicasRetry.where((politica) => !_politicas.contains(politica));
    _politicas.addAll(politicasNaoExistentes);
  }

  @override
  PoliticaRetry? getPolitica(String urlPath) {
    try {
      return _politicas.firstWhere(
        (rota) => urlPath.contains(rota.url),
        orElse: null,
      );
    } catch (e) {
      return null;
    }
  }

  void dispose() {
    _politicas.clear();
  }
}
