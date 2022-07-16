import 'dart:async';

import 'package:flutter/material.dart';
import 'package:storage_view/src/ui/controller/exceptions/exceptions.dart';
import 'package:storage_view/src/ui/controller/storage_viewer_controller.dart';
import 'package:storage_view/src/ui/utils/utils.dart';
import 'package:storage_view/src/ui/widgets/alerts/alerts.dart';
import 'package:storage_view/src/ui/widgets/forms/forms.dart';
import 'package:storage_view/src/ui/widgets/responsive/responsive_builder.dart';
import 'package:storage_view/src/ui/widgets/widgets.dart';
import 'package:storage_view/storage_view.dart';
import 'package:talker/talker.dart';

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
  final _searchController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<TalkerDataInterface>? _talkerExceptionsSub;

  @override
  void initState() {
    _initTalkerSubscription();
    _controller.load();
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        _controller.load();
      }
      _controller.search(_searchController.text);
    });
    super.initState();
  }

  void _initTalkerSubscription() {
    _talkerExceptionsSub = talker.stream.listen(
      (e) {
        if (e is TalkerException) {
          final exception = e.exception;
          if (exception is StorageDriverException) {
            _scaffoldKey.currentState?.showSnackBar(
              buildAlertSnackBar(
                title: exception.message,
                description: exception.exception.toString(),
              ),
            );
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _talkerExceptionsSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: FilledTextField(
                      controller: _searchController,
                      theme: widget.theme,
                      hintText: 'Search',
                    ),
                  ),
                  floating: true,
                ),
                SliverToBoxAdapter(
                  child: ResponsiveBuilder(
                    largeScreen: (context) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              margin: EdgeInsets.zero,
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
                      child: StorageTable(
                        theme: widget.theme,
                        controller: _controller,
                        storageEnties: storageEnties,
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
