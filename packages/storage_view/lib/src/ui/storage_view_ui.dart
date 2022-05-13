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
    final size = MediaQuery.of(context).size;
    return Material(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final data = _controller.data;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                columns: <DataColumn>[
                  DataColumn(
                    label: const Text(
                      'Key',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onSort: _controller.cangeFilter,
                  ),
                  DataColumn(
                    label: const Text(
                      'Value',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onSort: _controller.cangeFilter,
                  ),
                  DataColumn(
                    label: const Text(
                      'Type',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onSort: _controller.cangeFilter,
                  ),
                  const DataColumn(label: Text('')),
                ],
                rows: data.entries
                    .map(
                      (e) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text(e.key)),
                          DataCell(
                            Container(
                              constraints:
                                  BoxConstraints(maxWidth: size.width * 0.5),
                              child: Text('${e.value}'),
                            ),
                          ),
                          DataCell(Text('${e.value.runtimeType}')),
                          DataCell(Row(
                            children: [
                              IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: const Icon(Icons.close),
                              )
                            ],
                          )),
                        ],
                      ),
                    )
                    .toList()),
          );

          // ListView.builder(
          //   itemCount: data.length,
          //   itemBuilder: (context, i) => ListTile(
          //     title: Text(
          //       '${values[i].runtimeType} : ${keys[i]} : ${values[i]}',
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
