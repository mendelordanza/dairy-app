
import 'dart:convert';

import 'package:flutter/services.dart';

abstract class ConfigReader {
  static Map<String, dynamic>? _config;

  static Future<void> initialize() async {
    final configString = await rootBundle.loadString('config/app_config.json');
    _config = json.decode(configString) as Map<String, dynamic>;
  }

  static String getOpenAIKey() {
    return _config!['OPENAI_API_KEY'] as String;
  }

  static String getBaseUrl() {
    return _config!['BASE_URL'] as String;
  }
}