import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static const String key = "mikufans_local_history";
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return prefs.getBool(key) ?? defaultValue;
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return prefs.getInt(key) ?? defaultValue;
  }

  static double getDouble(String key, {double defaultValue = 1.0}) {
    return prefs.getDouble(key) ?? defaultValue;
  }

  static String getString(String key, {String defaultValue = ""}) {
    return prefs.getString(key) ?? defaultValue;
  }

  static void setBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  static void setDouble(String key, double value) {
    prefs.setDouble(key, value);
  }

  static void setString(String key, String value) {
    prefs.setString(key, value);
  }

  static void setInt(String key, int value) {
    prefs.setInt(key, value);
  }

  // static List<History> getLocalHistory() {
  //   // prefs.remove(key);
  //   final history = prefs.getStringList(key);
  //   if (history == null) {
  //     return [];
  //   }
  //   return history.map((e) => History.fromJson(json.decode(e))).toList();
  // }
  //
  // static void setLocalHistory(List<History> newHistory) {
  //   final Map<String, History> keep = {};
  //   for (final h in newHistory) {
  //     final id = h.media.id!;
  //     final old = keep[id];
  //     if (old == null || h.lastViewAt.isAfter(old.lastViewAt)) {
  //       keep[id] = h;
  //     }
  //   }
  //   final toSave = keep.values.toList()
  //     ..sort((a, b) => b.lastViewAt.compareTo(a.lastViewAt));
  //   prefs.setStringList(
  //     key,
  //     toSave.map((e) => jsonEncode(e.toJson())).toList(),
  //   );
  // }

  static void clearLocalHistory() {
    prefs.remove(key);
  }
}
