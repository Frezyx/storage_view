import 'dart:async';
import 'package:storage_view/storage_view.dart';
import 'package:uuid/uuid.dart';

class MockStorageDriver implements StorageDriver {
  static const _uuid = Uuid();

  late final _data = <String, dynamic>{
    _uuid.v4(): 'test',
    _uuid.v4(): 213234,
    _uuid.v4(): 234.56324,
    _uuid.v4(): 2378462354723,
    _uuid.v4(): Exception('Test exception'),
    'is_onboarding_shown': true,
    'is_app_traking_banner_shown': true,
    'selected_theme': 'light1',
    'shop_descriprion':
        '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum''',
    'shop_comment':
        'There are many variations of passages of Lorem Ipsum available, but the majority have suffered',
    _uuid.v4(): _uuid.v4(),
    _uuid.v4(): _uuid.v4(),
    _uuid.v4(): _uuid.v4(),
    _uuid.v4(): _uuid.v4(),
  };

  @override
  FutureOr<Set<String>> getKeys() {
    return _data.keys.toSet();
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
