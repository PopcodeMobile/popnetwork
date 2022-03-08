import 'package:popwork/src/mock/mock_strategy.dart';

class BaseStrategy implements MockStrategy {
  const BaseStrategy({String? jsonFile}) : _jsonFile = jsonFile;
  final String? _jsonFile;

  @override
  String? getNameJsonFile() {
    return _jsonFile;
  }
}
