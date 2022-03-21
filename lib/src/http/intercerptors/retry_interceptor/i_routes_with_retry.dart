import 'package:pop_network/src/http/intercerptors/retry_interceptor/politica_retry.dart';

abstract class IRoutesWithRetry {
  bool get isVazio;
  int get quantidade;
  PoliticaRetry? getPolitica(String urlPath);
}
