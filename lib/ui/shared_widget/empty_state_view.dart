import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:with_space_between/with_space_between.dart';

import '../../config/constant.dart';
import '../color.dart';
import '../dimension.dart';
import '../typography.dart';

class EmptyStateView extends StatelessWidget {
  final String title;
  final EmptyStateType type;
  final void Function()? onPressed;
  const EmptyStateView({
    super.key,
    required this.title,
    required this.type,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 280,
        padding: const EdgeInsets.symmetric(horizontal: space400, vertical: space300),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius750), color: bgSurfacePrimary),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              _getImage(type),
              height: 180,
              width: 180,
            ),
            Text(
              title,
              style: smBold.copyWith(color: textDarkPrimary),
            ),
            GestureDetector(
              onTap: onPressed,
              child: Text(
                'Muat Ulang',
                style: smBold.copyWith(color: primaryColor),
              ),
            ),
          ].withSpaceBetween(height: space300),
        ),
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
