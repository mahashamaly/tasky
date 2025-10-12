import 'package:shared_preferences/shared_preferences.dart';

// Class لإدارة SharedPreferences بطريقة منظمة (Singleton)
class PreferencesManager {
  // 1️⃣ إنشاء نسخة واحدة ثابتة (Singleton)
  static final PreferencesManager _instance = PreferencesManager._internal();
  // 2️⃣ factory constructor يرجع نفس النسخة دائماً عند استدعاء PreferencesManager()
  // يرجع النسخة الوحيدة
  factory PreferencesManager() {
    return _instance;
  }
  //// 3️⃣ constructor خاص داخلي لا يمكن استدعاؤه من خارج الكلاس
  //privet constractour
  PreferencesManager._internal();
  // 4️⃣ تخزين نسخة SharedPreferences الفعلية
  late final SharedPreferences _preferences;

  // 5️⃣ دالة تهيئة SharedPreferences
  // يجب استدعاؤها مرة واحدة قبل استخدام أي دالة أخرى
  init() async {
    _preferences = await SharedPreferences.getInstance();
  }
  // 6️⃣ دالة لاسترجاع قيمة String من SharedPreferences

  //set

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences.setStringList(key, value);
  }

  //get

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  List<String>? getStringList(String key) {
    return _preferences.getStringList(key);
  }

//deleat(هنا لحذف تاسك مثلا)
  remove(String key) async {
    await _preferences.remove(key);
  }
//هنا كل اشى بتحذف من الشير
clear()async{
  await _preferences.clear();
}

}
