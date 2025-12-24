import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:with_space_between/with_space_between.dart';

import '../../config/constant.dart';
import '../color.dart';
import '../dimension.dart';
import '../typography.dart';

class EmptyStateView extends StatelessWidget {
  final String title;
  final String? imagePath; // Bisa SVG atau Image biasa
  final bool isSvg; // Flag untuk membedakan SVG atau Image
  final EmptyStateType? type; // Optional, jika mau pakai type
  final void Function()? onPressed;

  const EmptyStateView({
    super.key,
    required this.title,
    this.imagePath,
    this.isSvg = true,
    this.type,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image/SVG
          if (imagePath != null)
            isSvg
                ? SvgPicture.asset(
              imagePath!,
              height: 200,
              width: 200,
            )
                : Image.asset(
              imagePath!,
              height: 100,
              width: 100,
            )
          else if (type != null)
            SvgPicture.asset(
              _getImage(type!),
              height: 200,
              width: 200,
            ),

          // Title
          Text(
            title,
            style: smBold.copyWith(color: textDarkPrimary),
            textAlign: TextAlign.center,
          ),

          // Button ULANGI with shadow
          if (onPressed != null)
            GestureDetector(
              onTap: onPressed,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: black00,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Text(
                  'ULANGI',
                  style: smBold.copyWith(
                    color: textDisabled,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
        ].withSpaceBetween(height: space300),
      ),
    );
  }

  String _getImage(EmptyStateType type) {
    switch (type) {
      case EmptyStateType.trx:
        return 'assets/images/img_no_transaction.svg';
      case EmptyStateType.voucher:
        return 'assets/images/img_voucher_illustration.svg';
      case EmptyStateType.notification:
        return 'assets/images/img_bel_illustration.svg';
      case EmptyStateType.assignment:
        return 'assets/images/img_no_task_Illustration.svg';
    }
  }
}
