import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:storage_view/storage_view.dart';

class SharedPreferencesDriver implements StorageDriver {
  SharedPreferencesDriver(this.secureStorage);

  final FlutterSecureStorage secureStorage;

  @override
  FutureOr<Set<String>> getKeys() async {
    final entries = await secureStorage.readAll();
    return entries.keys.toSet();
  }

  @override
  FutureOr<T?> read<T>(String key) async {
    final value = await secureStorage.read(key: key);
    if (value == null) {
      return null;
    }
    if (T is double) {
      return double.tryParse(value) as T?;
    }
    if (T is int) {
      return int.tryParse(value) as T?;
    }
    if (T is String) {
      return value as T?;
    }
    if (T is bool) {
      return (value == 'true') as T?;
    }
    return null;
  }

  @override
  FutureOr<void> write<T>({required String key, required T value}) async {
    if (value is int || value is double || value is String) {
      await secureStorage.write(key: key, value: value.toString());
      return;
    }
    if (value is List<String>) {
      await secureStorage.write(key: key, value: jsonEncode(value));
      return;
    }
    if (value is bool) {
      await secureStorage.write(key: key, value: value ? 'true' : 'fale');
      return;
    }
  }

  @override
  FutureOr<void> delete(String key) {
    secureStorage.delete(key: key);
  }
}
