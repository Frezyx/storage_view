import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:storage_view/storage_view.dart';

class FlutterSecureStorageDriver implements StorageDriver {
  FlutterSecureStorageDriver(this.secureStorage);

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

    return switch (T) {
      const (double) => double.tryParse(value) as T?,
      const (int) => int.tryParse(value) as T?,
      const (bool) => (value == 'true') as T?,
      _ => value as T?,
    };
  }

  @override
  FutureOr<void> write<T>({required String key, required T value}) async {
    switch (value) {
      case int() || double() || String() || bool():
        await secureStorage.write(key: key, value: value.toString());
      case List<String>():
        await secureStorage.write(key: key, value: jsonEncode(value));
    }
  }

  @override
  FutureOr<void> delete(String key) async =>
      await secureStorage.delete(key: key);
}
