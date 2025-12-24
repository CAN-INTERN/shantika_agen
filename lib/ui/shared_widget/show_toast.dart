import 'package:flutter/material.dart';

import '../color.dart';
import '../dimension.dart';
import '../typography.dart';

enum ToastType {
  success,
  error,
  warning,
  info,
}

class ToastConfig {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  ToastConfig({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
  });
}

class CustomToast {
  static ToastConfig _getConfig(ToastType type) {
    switch (type) {
      case ToastType.success:
        return ToastConfig(
          icon: Icons.check_circle,
          backgroundColor: green400,
          iconColor: black00,
          textColor: black00,
        );
      case ToastType.error:
        return ToastConfig(
          icon: Icons.error,
          backgroundColor: red600,
          iconColor: black00,
          textColor: black00,
        );
      case ToastType.warning:
        return ToastConfig(
          icon: Icons.warning,
          backgroundColor: Colors.orange,
          iconColor: black00,
          textColor: black00,
        );
      case ToastType.info:
        return ToastConfig(
          icon: Icons.info,
          backgroundColor: blue400,
          iconColor: black00,
          textColor: black00,
        );
    }
  }

  static void show(
      BuildContext context,
      String message, {
        ToastType type = ToastType.info,
        Duration duration = const Duration(seconds: 2),
      }) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.hideCurrentSnackBar();

    final config = _getConfig(type);
    final bottomMargin = MediaQuery.of(context).padding.bottom + 80;

    scaffold.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              config.icon,
              color: config.iconColor,
              size: 20,
            ),
            SizedBox(width: spacing3),
            Expanded(
              child: Text(
                message,
                style: smMedium.copyWith(color: config.textColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: config.backgroundColor,
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius200),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: padding16,
          vertical: padding12,
        ),
        margin: EdgeInsets.only(
          left: padding16,
          right: padding16,
          bottom: bottomMargin,
        ),
        duration: duration,
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    show(context, message, type: ToastType.success);
  }

  static void showError(BuildContext context, String message) {
    show(context, message, type: ToastType.error);
  }

  static void showWarning(BuildContext context, String message) {
    show(context, message, type: ToastType.warning);
  }

  static void showInfo(BuildContext context, String message) {
    show(context, message, type: ToastType.info);
  }
}

// Contoh penggunaan:
// CustomToast.showSuccess(context, 'Data berhasil disimpan!');
// CustomToast.showError(context, 'Terjadi kesalahan!');
// CustomToast.showWarning(context, 'Perhatian!');
// CustomToast.showInfo(context, 'Informasi penting');
//
// Atau dengan custom duration:
// CustomToast.show(
//   context,
//   'Pesan custom',
//   type: ToastType.success,
//   duration: Duration(seconds: 3),
// );