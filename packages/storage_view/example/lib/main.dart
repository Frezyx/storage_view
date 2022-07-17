import 'package:flutter/material.dart';
import 'package:storage_view/storage_view.dart';
import 'package:storage_view_example/mock_storage_driver/mock_storage_driver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _mockStorageDriver = MockStorageDriver();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(),
      ),
      home: Scaffold(
        body: StorageView(storageDriver: _mockStorageDriver),
      ),
    );
  }
}
