import 'package:flutter/material.dart';
import 'package:storage_view/src/models/models.dart';

class StorageViewerController extends ChangeNotifier {
  StorageViewerController(this._storage);

  final StorageDriver _storage;

  var _keys = <String>{};
  Set<String> get keys => _keys;

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
}
