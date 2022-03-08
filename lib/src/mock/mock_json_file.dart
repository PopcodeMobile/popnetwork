import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:network/network.dart';
import 'package:network/src/endpoint/endpoint.dart';

class MockJsonFile {
  static Future<dynamic> getDataFrom({required Endpoint endpoint}) async {
    var mockfile = endpoint.mockFile;
    if (endpoint.mockStrategy == null && mockfile != null) {
      final jsonFile = await _openFileAsString(mockfile);
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
