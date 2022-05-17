import 'package:flutter/material.dart';

const _columnTitleTextStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

const _cellTextStyle = TextStyle(color: Colors.white);

const _deleteIconTheme = IconThemeData(
  color: Colors.red,
  size: 20,
);

class StorageViewTheme {
  const StorageViewTheme({
    this.backgroundColor = const Color(0xFF1E1F28),
    this.cellTextStyle = _cellTextStyle,
    this.columnTitleTextStyle = _columnTitleTextStyle,
    this.deleteIconTheme = _deleteIconTheme,
    this.tableBorder,
    this.checkboxTheme,
  });

  final Color backgroundColor;
  final TextStyle? cellTextStyle;
  final TextStyle? columnTitleTextStyle;
  final IconThemeData? deleteIconTheme;
  final TableBorder? tableBorder;
  final CheckboxThemeData? checkboxTheme;

  factory StorageViewTheme.fromFlutterTheme(BuildContext context) {
    final t = Theme.of(context);
    return StorageViewTheme(
      backgroundColor: t.backgroundColor,
      cellTextStyle: t.textTheme.bodyText1,
      columnTitleTextStyle: t.textTheme.headline6,
      deleteIconTheme: t.primaryIconTheme,
    );
  }
}
