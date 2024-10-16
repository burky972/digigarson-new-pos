// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:core/base/model/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CacheKeys {
  token,
  refreshToken,
  user,
  currency,
  country_code,
  user_email,
  customPrinterList,
  tableLayout,
}

class SharedManager {
  SharedManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }
  static final SharedManager _instance = SharedManager._init();

  SharedPreferences? _preferences;
  static SharedManager get instance => _instance;
  static Future<void> preferencesInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _preferences!.clear();
  }

  Future<void> setStringValue(CacheKeys key, String value) async {
    await _preferences!.setString(key.name, value);
  }

  Future<void> setBoolValue(CacheKeys key, bool value) async {
    await _preferences!.setBool(key.name, value);
  }

  Future<void> setDoubleValue(CacheKeys key, double value) async {
    await _preferences!.setDouble(key.name, value);
  }

  Future<bool> setJsonModel<T extends BaseModel>(CacheKeys key, T model) async {
    var json = jsonEncode(model.toJson());
    if (json.isNotEmpty) {
      return await _preferences!.setString(key.name, json);
    }
    return false;
  }

  T? getJsonModel<T extends BaseModel>(CacheKeys key, T model) {
    var jsonString = _preferences?.getString(key.name);
    if (jsonString != null) {
      var jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return model.fromJson(jsonMap) as T;
    } else {
      return null;
    }
  }

  Future<bool> removeValue(String value) async {
    return await _preferences!.remove(value);
  }

  Future<void> setStringListValue(String key, List<String> value) async {
    await _preferences!.setStringList(key, value);
  }

  List<String>? getStringListValue(String key) => _preferences?.getStringList(key);
  String? getStringValue(String key) => _preferences?.getString(key);

  bool? getBoolValue(String key) => _preferences!.getBool(key);

  double? getDoubleValue(String key) => _preferences!.getDouble(key);

  bool containsKey(String key) => _preferences?.containsKey(key) ?? false;
}
