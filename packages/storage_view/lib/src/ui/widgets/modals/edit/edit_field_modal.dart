import 'package:flutter/material.dart';
import 'package:storage_view/src/extensions/extensions.dart';
import 'package:storage_view/src/ui/utils/validator/validator.dart';
import 'package:storage_view/src/ui/widgets/modals/edit/entry_info.dart';
import 'package:storage_view/src/ui/widgets/modals/edit/typed/typed.dart';
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
  var _boolValueUpdated = false;

  @override
  void initState() {
    _textController.text = widget.entry.value.toString();
    if (widget.entry.isBool) {
      _boolValueUpdated = widget.entry.value == 'true';
    }
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
                        onChange: (val) {
                          _boolValueUpdated = val;
                        },
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
                      if (widget.entry.isBool) {
                        widget.onUpdated(_boolValueUpdated);
                        Navigator.pop(context);
                        return;
                      }

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
