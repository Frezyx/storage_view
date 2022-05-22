import 'package:flutter/material.dart';
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
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        children: [
                          InfoRow(
                            title: 'Key',
                            value: widget.entry.key,
                            theme: widget.theme,
                          ),
                          InfoRow(
                            title: 'Value',
                            value: widget.entry.value.toString(),
                            theme: widget.theme,
                          ),
                          InfoRow(
                            title: 'Type',
                            value: widget.entry.value.runtimeType.toString(),
                            theme: widget.theme,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Edit value',
                      style: widget.theme.cellTextStyle?.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: widget.theme.editValueTextStyle,
                      controller: _textController,
                      maxLines: null,
                      minLines: 3,
                      decoration:
                          widget.theme.editValueInputDecoration?.copyWith(
                        hintText: 'Value',
                      ),
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
                    onPressed: () {
                      widget.onDeleted();
                      Navigator.pop(context);
                    },
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
                      widget.onUpdated(_textController.text);
                      Navigator.pop(context);
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
}
