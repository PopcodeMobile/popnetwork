import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:popwork/network.dart';
import 'package:popwork/src/endpoint/endpoint.dart';

class MockJsonFile {
  static Future<dynamic> getDataFrom({required Endpoint endpoint}) async {
    var mockName = endpoint.mockName;
    if (endpoint.mockStrategy == null && mockName != null) {
      final jsonFile = await _openFileAsString(mockName);
      return await _getData(jsonFile);
    }

    var jsonFile = endpoint.mockStrategy?.getNameJsonFile();
    if (jsonFile != null) {
      return await _getData(await _openFileAsString(jsonFile));
    }
    return null;
  }

  static Future<String> _openFileAsString(String nameFile) async {
    return await rootBundle.loadString('${Popwork.pathMocks}/$nameFile.json');
  }

  static Future<dynamic> _getData(String jsonFile) async {
    try {
      return json.decode(jsonFile);
    } catch (_) {
      return null;
    }
  }
}
