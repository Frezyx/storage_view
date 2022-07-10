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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          color: theme.lightCardColor,
          border: Border.all(
            color: !selected ? Colors.transparent : t.primaryColor,
          ),
          borderRadius: BorderRadius.circular(6),
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
