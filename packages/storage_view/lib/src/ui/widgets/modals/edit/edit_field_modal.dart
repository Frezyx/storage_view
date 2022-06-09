import 'package:flutter/material.dart';
import 'package:storage_view/src/extensions/extensions.dart';
import 'package:storage_view/src/ui/utils/validator/validator.dart';
import 'package:storage_view/src/ui/widgets/modals/edit/entry_info.dart';
import 'package:storage_view/src/ui/widgets/widgets.dart';
import 'package:storage_view/storage_view.dart';

class EditFieldModal extends StatefulWidget {
  const EditFieldModal({
    Key? key,
    required this.theme,
    required this.entry,
    required this.onDeleted,
    required this.onUpdated,
  }) : super(key: key);

  final StorageViewTheme theme;
  final MapEntry<String, dynamic> entry;
  final VoidCallback onDeleted;
  final Function(dynamic value) onUpdated;

  @override
  State<EditFieldModal> createState() => _EditFieldModalState();
}

class _EditFieldModalState extends State<EditFieldModal> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _textController.text = widget.entry.value.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: widget.theme.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit storage entry',
                      style: widget.theme.cellTextStyle?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Entry data',
                      style: widget.theme.cellTextStyle?.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    EntryInfo(theme: widget.theme, entry: widget.entry),
                    const SizedBox(height: 30),
                    Text(
                      'Edit value',
                      style: widget.theme.cellTextStyle?.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    if (widget.entry.isNum || widget.entry.isString)
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          style: widget.theme.editValueTextStyle,
                          controller: _textController,
                          maxLines: null,
                          minLines: 3,
                          validator: _getValidator(),
                          decoration:
                              widget.theme.editValueInputDecoration?.copyWith(
                            hintText: 'Value',
                          ),
                        ),
                      )
                    else if (widget.entry.isBool)
                      BoolValueSelector(
                        value: widget.entry.value,
                        theme: widget.theme,
                        onChange: (val) {},
                      ),
                  ],
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _delete,
                    label: const Text('Delete'),
                    icon: const Icon(Icons.close),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        widget.onUpdated(
                          _parseValueFromText(_textController.text),
                        );
                        Navigator.pop(context);
                      }
                    },
                    label: const Text('Save'),
                    icon: const Icon(Icons.save),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _delete() async {
    final confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmationModal(
        theme: widget.theme,
      ),
    );
    if (confirmDelete ?? false) {
      widget.onDeleted();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  dynamic _parseValueFromText(String value) {
    if (widget.entry.isInt) {
      return int.tryParse(value);
    }
    if (widget.entry.isDouble) {
      return double.tryParse(value);
    }
    return value;
  }

  String? Function(String? val)? _getValidator() {
    final validator = Validator();
    if (widget.entry.isInt) {
      return validator.isInt;
    }
    if (widget.entry.isDouble) {
      return validator.isDouble;
    }
    if (widget.entry.isString) {
      return validator.isString;
    }
    return validator.isNotEmpty;
  }
}

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
