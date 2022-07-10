import 'package:flutter/material.dart';
import 'package:storage_view/src/ui/widgets/forms/edit/typed/bool_selector/bool_selector_item.dart';
import 'package:storage_view/storage_view.dart';

class BoolValueSelector extends StatefulWidget {
  const BoolValueSelector({
    Key? key,
    required this.value,
    required this.onChange,
    required this.theme,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool> onChange;
  final StorageViewTheme theme;

  @override
  State<BoolValueSelector> createState() => _BoolValueSelectorState();
}

class _BoolValueSelectorState extends State<BoolValueSelector> {
  var _value = false;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoolSelectorItem(
          title: 'true',
          theme: widget.theme,
          onTap: () => _onChange(true),
          selected: _value == true,
        ),
        const SizedBox(height: 10),
        BoolSelectorItem(
          title: 'false',
          theme: widget.theme,
          onTap: () => _onChange(false),
          selected: _value == false,
        ),
      ],
    );
  }

  void _onChange(bool val) {
    widget.onChange(val);
    setState(() => _value = val);
  }
}
