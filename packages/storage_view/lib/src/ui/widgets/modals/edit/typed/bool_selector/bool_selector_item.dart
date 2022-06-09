import 'package:flutter/material.dart';
import 'package:storage_view/storage_view.dart';

class BoolSelectorItem extends StatelessWidget {
  const BoolSelectorItem({
    Key? key,
    required this.theme,
    required this.onTap,
    required this.title,
    required this.selected,
  }) : super(key: key);

  final StorageViewTheme theme;
  final VoidCallback onTap;
  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          border: Border.all(color: !selected ? Colors.white : t.primaryColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: !selected ? Colors.white : t.primaryColor,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
