import 'package:flutter/material.dart';

SnackBar buildErrorAlertSnackBar({
  required String title,
  String? description,
}) {
  return _buildDefaultSnackBar(
    title: title,
    description: description,
    color: Colors.red,
    icon: Icons.warning,
  );
}

SnackBar buildSuccessAlertSnackBar({
  required String title,
  String? description,
}) {
  return _buildDefaultSnackBar(
    title: title,
    description: description,
    color: Colors.green,
    icon: Icons.check,
  );
}

SnackBar _buildDefaultSnackBar({
  required String title,
  required String? description,
  required Color color,
  required IconData icon,
}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
    backgroundColor: color,
    content: Row(
      children: [
        Icon(icon, color: Colors.white),
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
