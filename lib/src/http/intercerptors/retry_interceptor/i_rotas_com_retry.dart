import 'package:network/src/http/intercerptors/retry_interceptor/politica_retry.dart';

abstract class IRotasComRetry {
  bool get isVazio;
  int get quantidade;
  PoliticaRetry? getPolitica(String urlPath);
}
