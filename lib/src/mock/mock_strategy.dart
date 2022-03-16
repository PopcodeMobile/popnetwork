///It is possible to create a strategy to get your mock files:
/// ```dart
/// final Endpoint endpoint = Endpoint(
///   mockStrategy: MockCustomStrategy(),
/// );

/// return await ApiManager.request(
///   endpoint: endpoint,
/// );

/// class MockCustomStrategy implements MockStrategy {
///   @override
///   String getNameJsonFile() {
///     final int random = Random().nextInt(2);
///     switch (random) {
///       case 0:
///         return 'json_1';
///       default:
///         return 'json_2';
///     }
///   }
/// }
/// ```

abstract class MockStrategy {
  String? getNameJsonFile();
}
