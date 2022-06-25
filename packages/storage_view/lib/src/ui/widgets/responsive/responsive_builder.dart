import 'package:flutter/material.dart';
import 'package:storage_view/src/ui/utils/utils.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  }) : super(key: key);

  final WidgetBuilder largeScreen;
  final WidgetBuilder? mediumScreen;
  final WidgetBuilder? smallScreen;

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (r.isLargeScreen) {
          return largeScreen.call(context);
        }
        if (r.isMediumScreen) {
          if (mediumScreen != null) {
            return mediumScreen!.call(context);
          }
          return largeScreen.call(context);
        }
        if (smallScreen != null) {
          return smallScreen!.call(context);
        }
        if (mediumScreen != null) {
          return mediumScreen!.call(context);
        }
        return largeScreen.call(context);
      },
    );
  }
}
