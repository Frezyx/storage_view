import 'package:flutter/material.dart';
import 'package:storage_view/src/models/models.dart';

class StorageViewerController extends ChangeNotifier {
  StorageViewerController(this._storage);

  final StorageDriver _storage;

  var _keys = <String>{};
  final _selectedKeys = <String>{};
  MapEntry<String, dynamic>? _selectedEntry;

  Set<String> get keys => _keys;
  Set<String> get selectedKeys => _selectedKeys;
  MapEntry<String, dynamic>? get selectedEntry => _selectedEntry;

  final _data = <String, dynamic>{};
  Map<String, dynamic> get data => _data;

  void selectEntry(MapEntry<String, dynamic> entry) {
    _selectedEntry = entry;
    notifyListeners();
  }

  Future<void> load() async {
    _keys = await _storage.getKeys();
    _data.clear();
    for (final key in keys) {
      final value = await _storage.read(key);
      _data[key] = value;
    }
    if (_data.isNotEmpty) {
      _selectedEntry = _data.entries.first;
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
