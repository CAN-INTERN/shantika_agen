import 'package:flutter/material.dart';

import '../color.dart';
import '../dimension.dart';
import '../typography.dart';

void showConsistentErrorToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.hideCurrentSnackBar();

  final topMargin = MediaQuery.of(context).padding.top + kToolbarHeight + 16;

  scaffold.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: smMedium.copyWith(color: black00),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: red600,
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
        top: topMargin,
        left: padding16,
        right: padding16,
        bottom: MediaQuery.of(context).size.height - topMargin - 80,
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}

void showConsistentSuccessToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.hideCurrentSnackBar();

  final topMargin = MediaQuery.of(context).padding.top + kToolbarHeight + 16;

  scaffold.showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(Icons.check_circle, color: black00, size: 20),
          SizedBox(width: spacing3),
          Expanded(
            child: Text(
              message,
              style: smMedium.copyWith(color: black00),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      backgroundColor: green400,
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
        top: topMargin,
        left: padding16,
        right: padding16,
        bottom: MediaQuery.of(context).size.height - topMargin - 80,
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}