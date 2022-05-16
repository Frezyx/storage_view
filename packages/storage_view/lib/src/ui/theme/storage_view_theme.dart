import 'package:flutter/material.dart';

class StorageViewTheme {
  const StorageViewTheme({
    this.backgroundColor = const Color(0xFF1E1F28),
    this.cellTextStyle,
    this.columnTitleTextStyle,
  });

  final Color backgroundColor;
  final TextStyle? cellTextStyle;
  final TextStyle? columnTitleTextStyle;

  StorageViewTheme mergeWithFlutetrTheme(BuildContext context) {
    final t = Theme.of(context);
    return StorageViewTheme(
      // backgroundColor: backgroundColor ?? t.backgroundColor,
      cellTextStyle: cellTextStyle ?? t.textTheme.bodyText1,
      columnTitleTextStyle: columnTitleTextStyle ?? t.textTheme.headline6,
    );
  }
}
