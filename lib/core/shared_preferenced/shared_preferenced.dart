import 'package:shared_preferences/shared_preferences.dart';

import '../enums/pr_keys_enum.dart';

class SharedPrefController {
  SharedPrefController._();

  static SharedPrefController? _instance;

  SharedPreferences? _sharedPreferences;

  factory SharedPrefController() => _instance ??= SharedPrefController._();

  Future<void> initPreferences() async =>
      _sharedPreferences = await SharedPreferences.getInstance();

  T? getValueFor<T>(String key) {
    if (_sharedPreferences!.containsKey(key)) _sharedPreferences!.get(key) as T;

    return null;
  }

  //==================> Set the language
  Future<bool> setLanguageCode({required String langCode}) async =>
      await _sharedPreferences!.setString(PrKeys.languageCode.name, langCode);

  //=========================> Set the Theme
  Future<bool> setTheme({required int themeCurrentIndex}) async =>
      await _sharedPreferences!.setInt(PrKeys.themeCurrentIndex.name, themeCurrentIndex);

  Future<bool> setString({required String key, required String value}) async =>
      await _sharedPreferences!.setString(key, value);

  void clear() async => _sharedPreferences!.clear();

  Future<bool> setIsLogin({required bool value}) async =>
      await _sharedPreferences!.setBool(PrKeys.isLogin.name, value);

  Future<bool> setMenuCurrentIndex({required int index}) async =>
      await _sharedPreferences!.setInt(PrKeys.menuCurrentIndex.name, index);

  Future<bool> setFlutterSdk({required String flutterSdkPath}) async =>
      await _sharedPreferences!.setString(PrKeys.flutterSdkPath.name, flutterSdkPath);
}
