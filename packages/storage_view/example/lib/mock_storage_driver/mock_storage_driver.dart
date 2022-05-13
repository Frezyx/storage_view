import 'dart:async';

import 'package:storage_view/storage_view.dart';

class MockStorageDriver implements StorageDriver {
  final _data = <String, dynamic>{
    '1': 'test',
    '2': 213234,
    '3': 234.56,
    '4': true,
    '5': Exception('Test exception'),
  };

  @override
  FutureOr<Set<String>> getKeys<String>() {
    return _data.keys.toSet() as Set<String>;
  }

  @override
  FutureOr<T?> read<T>(String key) {
    return _data[key] as T;
  }

  @override
  FutureOr<void> write<T>({required String key, required T value}) {
    _data[key] = value;
  }

  @override
  FutureOr<void> delete(String key) {
    _data.remove(key);
  }
}
