import 'package:flutter/material.dart';
import 'package:storage_view/src/models/models.dart';
import 'package:storage_view/src/ui/controller/exceptions/exceptions.dart';
import 'package:storage_view/src/ui/utils/utils.dart';

class StorageViewerController extends ChangeNotifier {
  StorageViewerController(this._storage);

  final StorageDriver _storage;

  var _keys = <String>{};
  final _selectedKeys = <String>{};
  MapEntry<String, dynamic>? _selectedEntry;

  Set<String> get keys => _keys;
  Set<String> get selectedKeys => _selectedKeys;
  MapEntry<String, dynamic>? get selectedEntry => _selectedEntry;
  bool get isOneKeySelected => _selectedKeys.isNotEmpty;

  var _data = <String, dynamic>{};
  Map<String, dynamic> get data => _data;

  void selectEntry(MapEntry<String, dynamic> entry) {
    _selectedEntry = entry;
    notifyListeners();
  }

  Future<void> load() async {
    try {
      _keys = await _storage.getKeys();
      _data.clear();
      for (final key in keys) {
        final value = await _storage.read(key);
        _data[key] = value;
      }
      if (_data.isNotEmpty) {
        _selectedEntry ??= _data.entries.first;
      }

      notifyListeners();
    } catch (e, st) {
      final exception = StorageDriverException(
        message: 'Load entries from storage exception',
        exception: e,
      );
      talker.handle(exception, st);
    }
  }

  void cangeFilter(int index, bool asc) {}

  void search(String query) {
    try {
      final matches = _data.entries.where((e) =>
          e.value.toString().contains(query) ||
          e.key.contains(query) ||
          e.value.runtimeType.toString().contains(query));

      final matchedMap = <String, dynamic>{};
      matchedMap.addEntries(matches);
      _data = matchedMap;
      notifyListeners();
    } catch (e, st) {
      final exception = StorageDriverException(
        message: 'Search entries storage exception',
        exception: e,
      );
      talker.handle(exception, st);
    }
  }

  Future<void> delete(String key) async {
    try {
      _storage.delete(key);
      talker.good('Value with key ($key) was deleted');
      await load();
    } catch (e, st) {
      final exception = StorageDriverException(
        message: 'Delete entry from storage exception',
        exception: e,
      );
      talker.handle(exception, st);
    }
  }

  Future<void> update(String key, dynamic value) async {
    try {
      await _storage.write(key: key, value: value);
      talker.good('Value with key ($key) was updated');
      await load();
    } catch (e, st) {
      final exception = StorageDriverException(
        message: 'Update entry storage exception',
        exception: e,
      );
      talker.handle(exception, st);
    }
  }

  Future<void> deleteSelectedEntries() async {
    try {
      for (final key in _selectedKeys) {
        await _storage.delete(key);
      }
      _selectedKeys.clear();
      talker.good('Successful delete (${_selectedKeys.length}) entries');
      await load();
    } catch (e, st) {
      final exception = StorageDriverException(
        message: 'Delete list entries storage exception',
        exception: e,
      );
      talker.handle(exception, st);
    }
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
