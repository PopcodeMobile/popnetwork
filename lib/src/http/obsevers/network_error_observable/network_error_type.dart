///Mapping the types of network errors that the package user can observe and use.
enum NetworkErrorType {
  ///Connecting to the api took a long time and timed out
  connectionTimeout,

  ///No internet connection
  noConnection,

  ///Page does not exist
  notFound,

  ///Inspired token
  expiredToken,
}
