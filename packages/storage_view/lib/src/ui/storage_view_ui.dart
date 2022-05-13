import 'package:flutter/material.dart';
import 'package:storage_view/src/models/storage_driver.dart';
import 'package:storage_view/src/ui/controller/storage_viewer_controller.dart';

class StorageView extends StatefulWidget {
  const StorageView({
    Key? key,
    required this.storageDriver,
  }) : super(key: key);

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
    return Material(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final data = _controller.data;
          final keys = data.keys.toList();
          final values = data.values.toList();
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) => ListTile(
              title: Text(
                '${values[i].type.title} : ${keys[i]} : ${values[i].value}',
              ),
            ),
          );
        },
      ),
    );
  }
}
