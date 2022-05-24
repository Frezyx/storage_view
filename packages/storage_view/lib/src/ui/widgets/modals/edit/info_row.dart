import 'package:flutter/material.dart';
import 'package:storage_view/storage_view.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    Key? key,
    required this.title,
    required this.value,
    required this.theme,
  }) : super(key: key);

  final String title;
  final String value;
  final StorageViewTheme theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.cellTextStyle?.copyWith(fontSize: 18),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: Text(
                value,
                style: theme.cellTextStyle?.copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
