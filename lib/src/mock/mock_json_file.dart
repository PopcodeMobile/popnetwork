import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pop_network/src/endpoint/endpoint.dart';
import 'package:pop_network/src/mock/mock_strategy.dart';
import 'package:pop_network/src/network.dart';

/// Responsible for managing files for requests.
class MockJsonFile {
  /// Responsible for getting the data from the file that are added to mock the features.
  static Future<dynamic> getDataFrom({
    required Endpoint endpoint,
    String? namePackege,
  }) async {
    var mockName = endpoint.mockName;
    if (endpoint.mockStrategy == null && mockName != null) {
      final jsonFile = await _openFileAsString(mockName, namePackege);
      return await _getData(jsonFile);
    }

    final mockStrategy = endpoint.mockStrategy;
    final String? jsonFile = mockStrategy?.getJson();

    if (jsonFile != null) {
      if (mockStrategy is NameMockStrategy) {
        return await _getData(await _openFileAsString(jsonFile, namePackege));
      } else {
        return await _getData(jsonFile);
      }
    }

    return null;
  }

  static Future<String> _openFileAsString(
      String nameFile, String? namePackage) async {
    return await rootBundle.loadString(
        '${namePackage != null ? 'packages/$namePackage/' : ''}${PopNetwork.pathMocks}/$nameFile.json');
  }

  /// Responsible for getting the data from the file that are added to mock the features.
  static Future<dynamic> _getData(String jsonFile) async {
    try {
      return json.decode(jsonFile);
    } catch (_) {
      return null;
    }
  }
}
