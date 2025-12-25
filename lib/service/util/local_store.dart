import 'dart:convert';

import 'package:mobile_holo/entity/history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  static const String _key = "holo_local_store";
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void addHistory(History history) {
    if (_prefs == null) return;
    var histories = _prefs!.getStringList(_key) ?? [];
    List<History> historyList = histories
        .map((jsonStr) => History.fromJson(json.decode(jsonStr)))
        .toList();
    historyList.add(history);
    Map<int, History> idToHistory = {};
    for (var item in historyList) {
      if (!idToHistory.containsKey(item.id) ||
          item.lastViewAt == null ||
          item.lastViewAt!.isAfter(idToHistory[item.id]!.lastViewAt!)) {
        idToHistory[item.id] = item;
      }
    }
    List<String> updatedHistories = idToHistory.values
        .map((item) => json.encode(item.toJson()))
        .toList();
    _prefs!.setStringList(_key, updatedHistories);
  }

  static History? getHistoryById(int id) {
    if (_prefs == null) return null;
    var histories = _prefs!.getStringList(_key) ?? [];
    List<History> historyList = histories
        .map((jsonStr) => History.fromJson(json.decode(jsonStr)))
        .toList();
    try {
      return historyList.firstWhere((history) => history.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<History> gerAllHistory() {
    if (_prefs == null) return [];
    var histories = _prefs!.getStringList(_key) ?? [];
    return histories
        .map((jsonStr) => History.fromJson(json.decode(jsonStr)))
        .toList();
  }

  static void deleteHistoryById(int id) {
    if (_prefs == null) return;
    var histories = _prefs!.getStringList(_key) ?? [];
    List<History> historyList = histories
        .map((jsonStr) => History.fromJson(json.decode(jsonStr)))
        .toList();
    historyList.removeWhere((history) => history.id == id);
    List<String> updatedHistories = historyList
        .map((item) => json.encode(item.toJson()))
        .toList();
    _prefs!.setStringList(_key, updatedHistories);
  }

  static void clearHistory() {
    if (_prefs == null) return;
    _prefs!.clear();
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs!.getBool(key) ?? defaultValue;
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  static double getDouble(String key, {double defaultValue = 1.0}) {
    return _prefs?.getDouble(key) ?? defaultValue;
  }

  static String getString(String key, {String defaultValue = ""}) {
    return _prefs?.getString(key) ?? defaultValue;
  }

  static void setBool(String key, bool value) {
    _prefs?.setBool(key, value);
  }

  static void setDouble(String key, double value) {
    _prefs?.setDouble(key, value);
  }

  static void setString(String key, String value) {
    _prefs?.setString(key, value);
  }

  static void setInt(String key, int value) {
    _prefs?.setInt(key, value);
  }
}
