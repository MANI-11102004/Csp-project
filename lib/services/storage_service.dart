import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keySavedVideos = 'saved_videos';
  static const String _keyCompletedVideos = 'completed_videos';
  static const String _keyPreferredLanguage = 'preferred_language';
  static const String _keyOnboardingComplete = 'onboarding_complete';
  static const String _keyUserData = 'user_data';
  static const String _keySurveyResults = 'survey_results';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<List<String>> getSavedVideoIds() async {
    final data = _prefs.getStringList(_keySavedVideos);
    return data ?? [];
  }

  Future<void> saveVideo(String videoId) async {
    final saved = await getSavedVideoIds();
    if (!saved.contains(videoId)) {
      saved.add(videoId);
      await _prefs.setStringList(_keySavedVideos, saved);
    }
  }

  Future<void> unsaveVideo(String videoId) async {
    final saved = await getSavedVideoIds();
    saved.remove(videoId);
    await _prefs.setStringList(_keySavedVideos, saved);
  }

  Future<bool> isVideoSaved(String videoId) async {
    final saved = await getSavedVideoIds();
    return saved.contains(videoId);
  }

  Future<List<String>> getCompletedVideoIds() async {
    final data = _prefs.getStringList(_keyCompletedVideos);
    return data ?? [];
  }

  Future<void> markVideoCompleted(String videoId) async {
    final completed = await getCompletedVideoIds();
    if (!completed.contains(videoId)) {
      completed.add(videoId);
      await _prefs.setStringList(_keyCompletedVideos, completed);
    }
  }

  Future<bool> isVideoCompleted(String videoId) async {
    final completed = await getCompletedVideoIds();
    return completed.contains(videoId);
  }

  Future<void> setPreferredLanguage(String languageCode) async {
    await _prefs.setString(_keyPreferredLanguage, languageCode);
  }

  Future<String> getPreferredLanguage() async {
    return _prefs.getString(_keyPreferredLanguage) ?? 'en';
  }

  Future<void> setOnboardingComplete(bool complete) async {
    await _prefs.setBool(_keyOnboardingComplete, complete);
  }

  Future<bool> isOnboardingComplete() async {
    return _prefs.getBool(_keyOnboardingComplete) ?? false;
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _prefs.setString(_keyUserData, jsonEncode(userData));
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final data = _prefs.getString(_keyUserData);
    if (data != null) {
      return jsonDecode(data);
    }
    return null;
  }

  Future<void> saveSurveyResult(Map<String, dynamic> result) async {
    final results = await getSurveyResults();
    results.add(result);
    await _prefs.setString(_keySurveyResults, jsonEncode(results));
  }

  Future<List<Map<String, dynamic>>> getSurveyResults() async {
    final data = _prefs.getString(_keySurveyResults);
    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);
      return decoded.cast<Map<String, dynamic>>();
    }
    return [];
  }

  Future<void> clearAllData() async {
    await _prefs.clear();
  }
}
