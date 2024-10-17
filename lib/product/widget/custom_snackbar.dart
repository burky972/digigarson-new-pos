// custom_snackbar.dart
import 'package:flutter/material.dart';

/// Snack bar types (success, error, warning, info)
enum SnackBarType { success, error, warning, info }

/// Custom SnackBar
class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onActionPressed,
    String? actionLabel,
  }) {
    /// Hide any previous snack bars
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Row(
        children: [
          _buildIcon(type),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      duration: duration,
      backgroundColor: _getBackgroundColor(type),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      elevation: 4,
      action: actionLabel != null && onActionPressed != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onActionPressed,
            )
          : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget _buildIcon(SnackBarType type) {
    IconData icon;
    Color color;

    switch (type) {
      case SnackBarType.success:
        icon = Icons.check_circle_outline;
        color = Colors.white;
        break;
      case SnackBarType.error:
        icon = Icons.error_outline;
        color = Colors.white;
        break;
      case SnackBarType.warning:
        icon = Icons.warning_amber;
        color = Colors.white;
        break;
      case SnackBarType.info:
        icon = Icons.info_outline;
        color = Colors.white;
        break;
    }

    return Icon(
      icon,
      color: color,
      size: 24,
    );
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green.shade600;
      case SnackBarType.error:
        return Colors.red.shade600;
      case SnackBarType.warning:
        return Colors.orange.shade700;
      case SnackBarType.info:
        return Colors.blue.shade600;
    }
  }
}
