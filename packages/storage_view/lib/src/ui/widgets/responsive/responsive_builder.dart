import 'package:flutter/material.dart';
import 'package:storage_view/src/ui/utils/utils.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  }) : super(key: key);

  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (r.isLargeScreen) {
          return largeScreen;
        }
        if (r.isMediumScreen) {
          return mediumScreen ?? largeScreen;
        }
        return smallScreen ?? mediumScreen ?? largeScreen;
      },
    );
  }
}
