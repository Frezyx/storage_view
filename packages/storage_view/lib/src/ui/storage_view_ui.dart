import 'package:flutter/material.dart';
import 'package:storage_view/src/ui/controller/storage_viewer_controller.dart';
import 'package:storage_view/src/ui/widgets/responsive/responsive_builder.dart';
import 'package:storage_view/src/ui/widgets/widgets.dart';
import 'package:storage_view/storage_view.dart';

class StorageView extends StatefulWidget {
  const StorageView({
    Key? key,
    required this.storageDriver,
    this.theme = const StorageViewTheme(),
  }) : super(key: key);

  final StorageViewTheme theme;
  final StorageDriver storageDriver;

  @override
  State<StorageView> createState() => _StorageViewState();
}

class _StorageViewState extends State<StorageView> {
  late final StorageViewerController _controller = StorageViewerController(
    widget.storageDriver,
  );

  @override
  void initState() {
    _controller.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.backgroundColor,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final storageEnties = _controller.data;
          return Theme(
            data: ThemeData(
              checkboxTheme:
                  widget.theme.checkboxTheme ?? _getDefaultCheckboxTheme(),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: ResponsiveBuilder(
                      largeScreen: (context) => Row(
                        children: [
                          if (_controller.selectedEntry != null)
                            Expanded(
                              child: EditFieldForm(
                                theme: widget.theme,
                                entry: _controller.selectedEntry!,
                                onDeleted: () {},
                                onUpdated: (_) {},
                              ),
                            ),
                          StorageTable(
                            theme: widget.theme,
                            controller: _controller,
                            storageEnties: storageEnties,
                          ),
                        ],
                      ),
                      mediumScreen: (context) => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: StorageTable(
                          theme: widget.theme,
                          controller: _controller,
                          storageEnties: storageEnties,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _getDefaultCheckboxTheme() {
    return CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      side: MaterialStateBorderSide.resolveWith(
          (_) => const BorderSide(width: 1, color: Colors.white)),
    );
  }
}
