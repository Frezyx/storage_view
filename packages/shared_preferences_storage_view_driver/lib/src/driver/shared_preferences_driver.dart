import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_view/storage_view.dart';

class SharedPreferencesDriver implements StorageDriver {
  SharedPreferencesDriver(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Set<String> getKeys() {
    return sharedPreferences.getKeys();
  }

  @override
  FutureOr<T?> read<T>(String key) {
    return sharedPreferences.get(key) as T;
  }

  @override
  FutureOr<void> write<T>({required String key, required T value}) async {
    if (value is int) {
      await sharedPreferences.setInt(key, value);
      return;
    }
    if (value is double) {
      await sharedPreferences.setDouble(key, value);
      return;
    }
    if (value is String) {
      await sharedPreferences.setString(key, value);
      return;
    }
    if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
      return;
    }
    if (value is bool) {
      await sharedPreferences.setBool(key, value);
      return;
    }
  }

  @override
  FutureOr<void> delete(String key) {
    sharedPreferences.remove(key);
  }
}
