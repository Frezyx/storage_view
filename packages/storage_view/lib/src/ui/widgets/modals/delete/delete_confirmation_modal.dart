import 'package:flutter/material.dart';
import 'package:storage_view/src/ui/utils/utils.dart';
import 'package:storage_view/storage_view.dart';

class DeleteConfirmationModal extends StatelessWidget {
  const DeleteConfirmationModal({
    Key? key,
    required this.theme,
    this.title = 'Are you realy want delete this field ?',
  }) : super(key: key);

  final StorageViewTheme theme;
  final String title;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ResponsiveHelper.of(context).isSmallScreen;
    final buttonHeight = isSmallScreen ? 50.0 : 50.0;
    return Center(
      child: Container(
        width: isSmallScreen ? null : 370,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: theme.editValueTextStyle?.copyWith(fontSize: 20),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SizedBox(
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('No'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      child: const Text('Yes'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
