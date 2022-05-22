import 'package:flutter/material.dart';
import 'package:storage_view/storage_view.dart';

class EditFieldModal extends StatefulWidget {
  const EditFieldModal({
    Key? key,
    required this.theme,
    required this.entry,
  }) : super(key: key);

  final StorageViewTheme theme;
  final MapEntry<String, dynamic> entry;

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
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.theme.backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: widget.theme.editValueTextStyle,
                  controller: _textController,
                  maxLines: null,
                  minLines: 3,
                  decoration: widget.theme.editValueInputDecoration?.copyWith(
                    hintText: 'Value',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
