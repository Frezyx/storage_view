abstract class StorageDriver {
  Future<List<String>> getKeys<String>();
  Future<void> write<T>({required String key, required T value});
  T? read<T>({required String key});
  Future<void> delete(String key);
}
