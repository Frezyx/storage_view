import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage_view_driver/flutter_secure_storage_view_driver.dart';

import 'package:storage_view/storage_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const srorage = FlutterSecureStorage();
  runApp(const SharedPreferencesExample(secureStorage: srorage));
}

class SharedPreferencesExample extends StatefulWidget {
  const SharedPreferencesExample({
    Key? key,
    required this.secureStorage,
  }) : super(key: key);

  final FlutterSecureStorage secureStorage;

  @override
  State<SharedPreferencesExample> createState() =>
      _SharedPreferencesExampleState();
}

class _SharedPreferencesExampleState extends State<SharedPreferencesExample> {
  @override
  void initState() {
    final rnd = Random();
    widget.secureStorage
      ..write(
        key: 'int ${rnd.nextInt(100).toString()}',
        value: '${rnd.nextInt(10000)}',
      )
      ..write(
        key: 'double ${rnd.nextInt(100).toString()}',
        value: '${rnd.nextDouble()}',
      )
      ..write(
        key: 'String  ${rnd.nextInt(100).toString()}',
        value: DateTime.now().toIso8601String(),
      )
      ..write(
        key: 'bool ${rnd.nextInt(100).toString()}',
        value: 'false',
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferencesExample',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
      ),
      home: Scaffold(
        body: StorageView(
          storageDriver: FlutterSecureStorageDriver(widget.secureStorage),
        ),
      ),
    );
  }
}
