import 'package:flutter/material.dart';

SnackBar buildAlertSnackBar({
  required String title,
  String? description,
}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
    backgroundColor: Colors.red,
    content: Row(
      children: [
        const Icon(Icons.warning, color: Colors.white),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (description != null)
                Text(
                  description,
                  style: const TextStyle(color: Colors.white),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
