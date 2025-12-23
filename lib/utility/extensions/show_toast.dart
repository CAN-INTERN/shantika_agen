import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/constant.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_card_secondary.dart';
import '../../ui/typography.dart';

extension ToastExtension on BuildContext {
  void showCustomToast({
    required String title,
    required String message,
    required bool isSuccess,
    Duration? duration,
    SnackBarPosition? position,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: duration ?? const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(this).size.height * (position == SnackBarPosition.top ? 0.75 : 0.10),
          left: 16,
          right: 16,
          top: kToolbarHeight,
        ),
        animation: CurvedAnimation(
          parent: AnimationController(
            vsync: Scaffold.of(this),
            duration: const Duration(milliseconds: 300),
          )..forward(),
          curve: Curves.easeOut,
        ),
        content: CustomCardSecondary(
          useShadow: false,
          leftColor: isSuccess ? iconInfo : iconDanger,
          child: Container(
            decoration: BoxDecoration(
              color: isSuccess ? bgSurfaceInfo : bgSurfaceDanger,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/images/ic_info.svg', color: isSuccess ? iconInfo : iconDanger),
                  const SizedBox(width: space200),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: smMedium.copyWith(color: isSuccess ? iconInfo : iconDanger)),
                        Text(
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          message,
                          style: xsRegular.copyWith(color: isSuccess ? iconInfo : iconDanger),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset('assets/images/ic_close_circle.svg', color: isSuccess ? iconInfo : iconDanger),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
