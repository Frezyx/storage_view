import 'package:flutter/material.dart';
import 'package:storage_view/src/ui/widgets/widgets.dart';
import 'package:storage_view/storage_view.dart';

class EntryInfo extends StatelessWidget {
  const EntryInfo({
    Key? key,
    required this.theme,
    required this.entry,
  }) : super(key: key);

  final StorageViewTheme theme;
  final MapEntry<String, dynamic> entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          InfoRow(
            title: 'Key',
            value: entry.key,
            theme: theme,
          ),
          InfoRow(
            title: 'Value',
            value: entry.value.toString(),
            theme: theme,
          ),
          InfoRow(
            title: 'Type',
            value: entry.value.runtimeType.toString(),
            theme: theme,
          ),
        ],
      ),
    );
  }
}
