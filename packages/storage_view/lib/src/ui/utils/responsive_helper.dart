import 'package:flutter/material.dart';

class ResponsiveHelper {
  const ResponsiveHelper._(this.context);

  final BuildContext context;

  factory ResponsiveHelper.of(BuildContext context) =>
      ResponsiveHelper._(context);

  bool get isSmallScreen => MediaQuery.of(context).size.width < 800;

  bool get isLargeScreen => MediaQuery.of(context).size.width > 1000;

  bool get isMediumScreen =>
      MediaQuery.of(context).size.width >= 800 &&
      MediaQuery.of(context).size.width <= 1200;
}
