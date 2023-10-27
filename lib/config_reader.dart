import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class ConfigReader {
  static Map<String, dynamic>? _config;

  static Future<void> initialize() async {
    String configString = "";
    final platform = await PackageInfo.fromPlatform();
    if (platform.packageName.contains(".dev")) {
      configString = await rootBundle.loadString('config/app_config_dev.json');
    } else {
      configString = await rootBundle.loadString('config/app_config.json');
    }
    _config = json.decode(configString) as Map<String, dynamic>;
  }

  static String getOpenAIKey() {
    return _config!['OPENAI_API_KEY'] as String;
  }

  static String getBaseUrl() {
    return _config!['BASE_URL'] as String;
  }

  static String getApiUrl() {
    return _config!['API_URL'] as String;
  }

  static String getAnonKey() {
    return _config!['ANON_KEY'] as String;
  }

  static String getAppleKey() {
    return _config!['APPLE_KEY'] as String;
  }

  static String getFacebookId() {
    return _config!['FACEBOOK_ID'] as String;
  }
}
