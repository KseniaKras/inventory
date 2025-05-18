import 'package:flutter/material.dart';

enum NotificationType { info, success, error }

class NotificationUtil {
  NotificationUtil._();

  static void showNotificationMessage(
    BuildContext context,
    String message, {
    NotificationType type = NotificationType.info,
    int durationSeconds = 5,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final Color backgroundColor = _getBackgroundColor(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        showCloseIcon: true,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: durationSeconds),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static Color _getBackgroundColor(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return Colors.green;
      case NotificationType.error:
        return Colors.red;
      case NotificationType.info:
        return Colors.orange;
    }
  }
}
