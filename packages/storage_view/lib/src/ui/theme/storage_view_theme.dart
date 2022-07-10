import 'package:flutter/material.dart';

const _columnTitleTextStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

const _cellTextStyle = TextStyle(color: Colors.white);

const _deleteIconTheme = IconThemeData(
  color: Colors.red,
  size: 20,
);

const _textFieldBorder =
    OutlineInputBorder(borderSide: BorderSide(color: Colors.white));
const _textFieldErrorBorder =
    OutlineInputBorder(borderSide: BorderSide(color: Colors.red));

const _editValueInputDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  ),
  floatingLabelStyle: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
  ),
  filled: true,
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
  floatingLabelBehavior: FloatingLabelBehavior.never,
  enabledBorder: _textFieldBorder,
  focusedBorder: _textFieldBorder,
  border: _textFieldBorder,
  errorBorder: _textFieldErrorBorder,
);

class StorageViewTheme {
  const StorageViewTheme({
    this.backgroundColor = const Color(0xFF1E1F28),
    this.cellTextStyle = _cellTextStyle,
    this.columnTitleTextStyle = _columnTitleTextStyle,
    this.deleteIconTheme = _deleteIconTheme,
    this.tableBorder,
    this.checkboxTheme,
    this.editValueInputDecoration = _editValueInputDecoration,
    this.editValueTextStyle = const TextStyle(color: Colors.white),
    this.deleteIcon,
    this.cardColor = const Color(0xFF2A2C36),
    this.lightCardColor = const Color(0xFF3C3E4E),
  });

  final Color backgroundColor;
  final TextStyle? cellTextStyle;
  final TextStyle? columnTitleTextStyle;
  final IconThemeData? deleteIconTheme;
  final TableBorder? tableBorder;
  final CheckboxThemeData? checkboxTheme;
  final InputDecoration? editValueInputDecoration;
  final TextStyle? editValueTextStyle;
  final Widget? deleteIcon;
  final Color cardColor;
  final Color lightCardColor;

  factory StorageViewTheme.fromFlutterTheme(BuildContext context) {
    final t = Theme.of(context);
    return StorageViewTheme(
      backgroundColor: t.backgroundColor,
      cellTextStyle: t.textTheme.bodyText1,
      columnTitleTextStyle: t.textTheme.headline6,
      deleteIconTheme: t.primaryIconTheme,
      editValueTextStyle: t.textTheme.bodyText1,
    );
  }
}
