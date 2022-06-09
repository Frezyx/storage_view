import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_storage_view_driver/shared_preferences_storage_view_driver.dart';
import 'package:storage_view/storage_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(SharedPreferencesExample(sharedPreferences: prefs));
}

class SharedPreferencesExample extends StatefulWidget {
  const SharedPreferencesExample({
    Key? key,
    required this.sharedPreferences,
  }) : super(key: key);

  final SharedPreferences sharedPreferences;

  @override
  State<SharedPreferencesExample> createState() =>
      _SharedPreferencesExampleState();
}

class _SharedPreferencesExampleState extends State<SharedPreferencesExample> {
  @override
  void initState() {
    final rnd = Random();
    widget.sharedPreferences
      ..setInt('int ${rnd.nextInt(100).toString()}', rnd.nextInt(10000))
      ..setDouble('double ${rnd.nextInt(100).toString()}', rnd.nextDouble())
      ..setString('String  ${rnd.nextInt(100).toString()}',
          DateTime.now().toIso8601String())
      ..setBool('bool ${rnd.nextInt(100).toString()}', false);
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
          storageDriver: SharedPreferencesDriver(widget.sharedPreferences),
        ),
      ),
    );
  }
}
