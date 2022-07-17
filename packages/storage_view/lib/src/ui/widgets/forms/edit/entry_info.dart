import 'package:flutter/material.dart';
import 'package:storage_view/src/ui/widgets/forms/edit/info_row.dart';
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
    return Column(
      children: [
        InfoRow(
          title: 'Key',
          value: entry.key,
          theme: theme,
        ),
        // const SizedBox(height: 10),
        // InfoRow(
        //   title: 'Value',
        //   value: entry.value.toString(),
        //   theme: theme,
        // ),
      ],
    );
  }
}
