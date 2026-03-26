import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_secure_storage_view_driver/driver/driver.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_secure_storage.dart';

void main() {
  final mockSecureStoragePlatform = MockSecureStoragePlatform();
  FlutterSecureStoragePlatform.instance = mockSecureStoragePlatform;

  const boolKey = 'boolKey';
  const intKey = 'intKey';
  const doubleKey = 'doubleKey';
  const stringKey = 'stringKey';
  const listKey = 'listKey';

  const keyPairs = <String, String>{
    boolKey: 'true',
    intKey: '42',
    doubleKey: '3.14',
    stringKey: 'Hello, World!',
    listKey: '["item1", "item2", "item3"]',
  };

  setUp(() {
    when(() => mockSecureStoragePlatform.readAll(options: any(named: 'options')))
        .thenAnswer((_) async => Future.value(keyPairs));
  });

  tearDown(() {
    logInvocations([mockSecureStoragePlatform]);
    reset(mockSecureStoragePlatform);
  });

  group('Reading secure storage', () {
    setUp(() {
      when(() => mockSecureStoragePlatform.read(key: boolKey, options: any(named: 'options')))
          .thenAnswer((_) async => Future.value(keyPairs[boolKey]));
      when(() => mockSecureStoragePlatform.read(key: intKey, options: any(named: 'options')))
          .thenAnswer((_) async => Future.value(keyPairs[intKey]));
      when(() => mockSecureStoragePlatform.read(key: doubleKey, options: any(named: 'options')))
          .thenAnswer((_) async => Future.value(keyPairs[doubleKey]));
      when(() => mockSecureStoragePlatform.read(key: stringKey, options: any(named: 'options')))
          .thenAnswer((_) async => Future.value(keyPairs[stringKey]));
      when(() => mockSecureStoragePlatform.read(key: listKey, options: any(named: 'options')))
          .thenAnswer((_) async => Future.value(keyPairs[listKey]));
    });

    test('Calling readAll returns all stored keys', () async {
      final driver = FlutterSecureStorageDriver(const FlutterSecureStorage());

      final keys = await driver.getKeys();

      expect(keys, containsAll(keyPairs.keys));
    });

    test('Calling read for each type correctly parses and returns the expected value', () async {
      final driver = FlutterSecureStorageDriver(const FlutterSecureStorage());

      final boolValue = await driver.read<bool>(boolKey);
      final intValue = await driver.read<int>(intKey);
      final doubleValue = await driver.read<double>(doubleKey);
      final stringValue = await driver.read<String>(stringKey);
      final listValue = await driver.read<String>(listKey);

      expect(boolValue, true);
      expect(intValue, 42);
      expect(doubleValue, 3.14);
      expect(stringValue, 'Hello, World!');
      expect(listValue, '["item1", "item2", "item3"]');
    });
  });

  group('Writing to secure storage', () {
    setUp(() {
      when(() => mockSecureStoragePlatform.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
          options: any(named: 'options'))).thenAnswer(
        (_) => Future.value(),
      );
    });

    test('Calling write with each supported type stores the value as the expected value and type',
        () async {
      final driver = FlutterSecureStorageDriver(const FlutterSecureStorage());

      await driver.write<bool>(key: boolKey, value: false);
      await driver.write<int>(key: intKey, value: 100);
      await driver.write<double>(key: doubleKey, value: 2.718);
      await driver.write<String>(key: stringKey, value: 'Goodbye, World!');
      await driver.write<List<String>>(key: listKey, value: ['itemA', 'itemB']);

      verifyInOrder([
        () => mockSecureStoragePlatform.write(
            key: boolKey, value: 'false', options: any(named: 'options')),
        () => mockSecureStoragePlatform.write(
            key: intKey, value: '100', options: any(named: 'options')),
        () => mockSecureStoragePlatform.write(
            key: doubleKey, value: '2.718', options: any(named: 'options')),
        () => mockSecureStoragePlatform.write(
            key: stringKey, value: 'Goodbye, World!', options: any(named: 'options')),
        () => mockSecureStoragePlatform.write(
            key: listKey, value: '["itemA","itemB"]', options: any(named: 'options')),
      ]);
    });
  });
}
