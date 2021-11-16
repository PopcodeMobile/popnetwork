class QueryFormatter {
  static String formatQueryParameters(
      {required Map<String, dynamic>? parameters}) {
    String queryParameters = '?';
    if (parameters != null) {
      parameters.forEach(
          (String k, dynamic v) => queryParameters = '$queryParameters$k=$v&');
    }
    return queryParameters.substring(0, queryParameters.length - 1);
  }
}
