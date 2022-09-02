import 'dart:async';

abstract class StorageDriver {
  FutureOr<Set<String>> getKeys();
  FutureOr<T?> read<T>(String key);
  FutureOr<void> write<T>({required String key, required T value});
  FutureOr<void> delete(String key);
}
