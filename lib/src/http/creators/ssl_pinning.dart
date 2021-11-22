import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class SSLPinning {
  Future<void> pinningCertificate({
    @required HttpClientAdapter httpClientAdapter,
  });
}
