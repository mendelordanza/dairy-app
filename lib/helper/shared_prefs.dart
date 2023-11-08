import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static const String KEY_IS_FINISHED = "key_is_finished";
  static const String KEY_SHOULD_SHOW_REVIEW = "key_should_show_review";
  static const String KEY_BIOMETRICS = "key_biometrics";
  static const String KEY_LAST_REVIEW = "key_last_review";

  Future setFinishedOnboarding(bool isFinished) async {
    await _preferences?.setBool(KEY_IS_FINISHED, isFinished);
  }

  bool? getFinishedOnboarding() => _preferences?.getBool(KEY_IS_FINISHED);

  Future setShouldShowReview(bool shouldShow) async {
    await _preferences?.setBool(KEY_SHOULD_SHOW_REVIEW, shouldShow);
  }

  bool getShouldShowReview() =>
      _preferences?.getBool(KEY_SHOULD_SHOW_REVIEW) ?? true;

  Future setLastReview(int lastReview) async {
    await _preferences?.setInt(KEY_LAST_REVIEW, lastReview);
  }

  int? getLastReview() => _preferences?.getInt(KEY_LAST_REVIEW);

  Future setBiometricsEnabled(bool isEnabled) async {
    await _preferences?.setBool(KEY_BIOMETRICS, isEnabled);
  }

  bool? getBiometricsEnabled() => _preferences?.getBool(KEY_BIOMETRICS);
}
