import 'package:shared_preferences/shared_preferences.dart';

abstract class ISharedPref {
  Future setUp();

  Future<bool> setStringList(
      {required String key, required List<String> values});

  Future delete({required String key});

  Future<List<String>> getList({required String key});

  Future<bool> isLoggedIn();

  Future loggedIn();

  Future loggedOut();
}

class SharedPref extends ISharedPref {
  SharedPref._internal();

  static final SharedPref instance = SharedPref._internal();

  factory SharedPref() => instance;
  SharedPreferences? _sharedPreferences;

  @override
  Future setUp() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> setStringList(
      {required String key, required List<String> values}) async {
    final response = await _sharedPreferences?.setStringList(key, values);
    return response ?? false;
  }

  @override
  Future<List<String>> getList({required String key}) async {
    final data = await _sharedPreferences?.getStringList(key) ?? [];
    return data;
  }

  @override
  Future delete({required String key}) async {
    await _sharedPreferences?.remove(key);
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _sharedPreferences?.getBool("login") ?? false;
  }

  @override
  Future loggedIn() async {
    _sharedPreferences?.setBool("login", true);
  }

  @override
  Future loggedOut() async {
    _sharedPreferences?.setBool("login", false);
  }
}
