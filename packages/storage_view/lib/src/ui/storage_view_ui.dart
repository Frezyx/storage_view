import 'package:flutter/material.dart';
import 'package:storage_view/src/ui/controller/storage_viewer_controller.dart';
import 'package:storage_view/src/ui/widgets/forms/edit/edit_field_form.dart';
import 'package:storage_view/src/ui/widgets/forms/forms.dart';
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
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  toolbarHeight: 70,
                  backgroundColor: widget.theme.cardColor,
                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: FilledTextField(
                      theme: widget.theme,
                      hintText: 'Search',
                    ),
                  ),
                  floating: true,
                ),
                SliverToBoxAdapter(
                  child: ResponsiveBuilder(
                    largeScreen: (context) => Row(
                      children: [
                        StorageTable(
                          theme: widget.theme,
                          controller: _controller,
                          storageEnties: storageEnties,
                        ),
                        if (_controller.selectedEntry != null)
                          Expanded(
                            flex: 1,
                            child: EditFieldForm(
                              theme: widget.theme,
                              entry: _controller.selectedEntry!,
                              onDeleted: () {
                                _controller
                                    .delete(_controller.selectedEntry!.key);
                              },
                              onUpdated: (value) {
                                _controller.update(
                                  _controller.selectedEntry!.key,
                                  value,
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                    smallScreen: (context) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0)
                            .copyWith(top: 20),
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
