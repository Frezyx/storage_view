import 'package:flutter/material.dart';
import 'package:storage_view/src/models/models.dart';

class StorageViewerController extends ChangeNotifier {
  StorageViewerController(this._storage);

  final StorageDriver _storage;

  var _keys = <String>{};
  Set<String> get keys => _keys;

  var _selectedKeys = <String>{};
  Set<String> get selectedKeys => _selectedKeys;

  final _data = <String, dynamic>{};
  Map<String, dynamic> get data => _data;

  Future<void> load() async {
    _keys = await _storage.getKeys();
    _data.clear();
    for (final key in keys) {
      final value = await _storage.read(key);
      _data[key] = value;
    }
    notifyListeners();
  }

  void cangeFilter(int index, bool asc) {}

  Future<void> delete(String key) async {
    _storage.delete(key);
    await load();
  }

  Future<void> update(String key, dynamic value) async {
    await _storage.write(key: key, value: value);
    await load();
  }

  void toggleAllKeys(bool? selected) {
    if (selected ?? true) {
      _selectedKeys.addAll(_keys);
      notifyListeners();
      return;
    }
    _selectedKeys.clear();
    notifyListeners();
  }

  void setKeySelected(String key) {
    if (_selectedKeys.contains(key)) {
      _selectedKeys.remove(key);
      notifyListeners();
      return;
    }
    _selectedKeys.add(key);
    notifyListeners();
  }
}
