import 'package:pop_network/src/http/intercerptors/retry_interceptor/policy_retry.dart';

///contract to assign the retry policy to a class
abstract class IRoutesWithRetry {
  ///Check if the retry policy is empty
  bool get isEmpty;

  ///Evaluates the quality of the retry policy.
  int get length;
  PolicyRetry? getPolicy(String urlPath);
}
