/// Responsible for giving a standard response for the return of the request
class RawResponse {
  RawResponse({
    required this.statusCode,
    required this.data,
  });

  final int statusCode;
  final dynamic data;
}
