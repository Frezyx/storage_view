import 'package:flutter/material.dart';
import 'package:storage_view/src/ui/controller/storage_viewer_controller.dart';
import 'package:storage_view/src/ui/widgets/edit_field_modal.dart';
import 'package:storage_view/storage_view.dart';

class StorageView extends StatefulWidget {
  const StorageView({
    Key? key,
    required this.storageDriver,
    this.theme = const StorageViewTheme(),
    this.deleteIcon,
  }) : super(key: key);

  final StorageViewTheme theme;
  final StorageDriver storageDriver;
  final Widget? deleteIcon;

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
    final deleteIconTheme = widget.theme.deleteIconTheme;
    return SafeArea(
      child: Material(
        color: widget.theme.backgroundColor,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final data = _controller.data;
            return Theme(
              data: ThemeData(
                checkboxTheme:
                    widget.theme.checkboxTheme ?? _getDefaultCheckboxTheme(),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: const BoxDecoration(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          checkboxHorizontalMargin: 16,
                          border: widget.theme.tableBorder ??
                              _getDefaultTableBorder(),
                          columns: <DataColumn>[
                            DataColumn(
                              label: Container(
                                constraints:
                                    BoxConstraints(maxWidth: size.width * 0.1),
                                child: Text(
                                  'Key',
                                  style: widget.theme.columnTitleTextStyle,
                                ),
                              ),
                              onSort: _controller.cangeFilter,
                            ),
                            DataColumn(
                              label: Text(
                                'Value',
                                style: widget.theme.columnTitleTextStyle,
                              ),
                              onSort: _controller.cangeFilter,
                            ),
                            DataColumn(
                              label: Text(
                                'Type',
                                style: widget.theme.columnTitleTextStyle,
                              ),
                              onSort: _controller.cangeFilter,
                            ),
                            const DataColumn(label: Text('')),
                          ],
                          rows: data.entries
                              .map(
                                (e) => DataRow(
                                  onLongPress: () => _showEditPreviewDialog(e),
                                  onSelectChanged: (_) {},
                                  cells: <DataCell>[
                                    DataCell(
                                      Text(
                                        e.key,
                                        style: widget.theme.cellTextStyle,
                                      ),
                                      onTap: () => _showEditPreviewDialog(e),
                                    ),
                                    DataCell(
                                      Container(
                                        constraints: BoxConstraints(
                                            maxWidth: size.width * 0.5),
                                        child: Text(
                                          '${e.value}',
                                          style: widget.theme.cellTextStyle,
                                        ),
                                      ),
                                      onTap: () => _showEditPreviewDialog(e),
                                    ),
                                    DataCell(
                                      Text(
                                        '${e.value.runtimeType}',
                                        style: widget.theme.cellTextStyle,
                                      ),
                                      onTap: () => _showEditPreviewDialog(e),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {},
                                            child: widget.deleteIcon ??
                                                Icon(
                                                  Icons.close,
                                                  color: deleteIconTheme?.color,
                                                  size: deleteIconTheme?.size,
                                                ),
                                          )
                                        ],
                                      ),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showEditPreviewDialog(MapEntry<String, dynamic> e) {
    showDialog(
      context: context,
      builder: (context) => EditFieldModal(
        theme: widget.theme,
        entry: e,
        onDeleted: () => _controller.delete(e.key),
        onUpdated: (value) => _controller.update(e.key, value),
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

  TableBorder _getDefaultTableBorder() {
    return TableBorder.all(color: Colors.white.withOpacity(0.2), width: 1);
  }
}
