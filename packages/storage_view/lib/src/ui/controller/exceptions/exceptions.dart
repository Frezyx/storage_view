class StorageDriverException implements Exception {
  const StorageDriverException({
    required this.message,
    required this.exception,
  });

  final String message;
  final Object exception;
}
