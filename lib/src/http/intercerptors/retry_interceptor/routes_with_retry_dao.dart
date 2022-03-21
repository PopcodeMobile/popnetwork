import 'package:pop_network/src/http/intercerptors/retry_interceptor/i_routes_with_retry.dart';
import 'package:pop_network/src/http/intercerptors/retry_interceptor/policy_retry.dart';

///Implementation of the retry policy.
class RoutesWithRetryDAO implements IRoutesWithRetry {
  RoutesWithRetryDAO._();

  static final RoutesWithRetryDAO _instance = RoutesWithRetryDAO._();

  static RoutesWithRetryDAO get instance => _instance;

  final Set<PolicyRetry> _policy = {};

  @override
  bool get isEmpty => _policy.isEmpty;

  @override
  int get length => _policy.length;

  ///Responsible for adding the retry policy to your given route.
  void addPolicyRetry(PolicyRetry policyRetry) {
    if (!_policy.contains(policyRetry)) {
      _policy.add(policyRetry);
    }
  }

  ///Responsible for adding multiple Retry policies
  void addMultipleRetryPolicies(List<PolicyRetry> policysRetry) {
    final nonExistingPolicies =
        policysRetry.where((policy) => !_policy.contains(policy));
    _policy.addAll(nonExistingPolicies);
  }

  @override
  PolicyRetry? getPolicy(String urlPath) {
    try {
      return _policy.firstWhere(
        (route) => urlPath.contains(route.url),
        orElse: null,
      );
    } catch (e) {
      return null;
    }
  }

  ///Responsible for clearing the retry policy.
  void dispose() {
    _policy.clear();
  }
}
