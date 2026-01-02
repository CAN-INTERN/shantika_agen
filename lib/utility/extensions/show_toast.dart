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
          top: 0,
          bottom: 4,
          left: 16,
          right: 16,
        ),
        content: CustomCardSecondary(
          useShadow: false,
          leftColor: isSuccess ? successColor : iconDanger,
          child: Container(
            decoration: BoxDecoration(
              color: isSuccess ? bgHoverSuccess : bgSurfaceDanger,
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
                  SvgPicture.asset(
                    'assets/images/ic_info.svg',
                    color: isSuccess ? successColor : iconDanger,
                  ),
                  SizedBox(width: space200),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: smMedium.copyWith(
                            color: isSuccess ? successColor : iconDanger,
                          ),
                        ),
                        Text(
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          message,
                          style: xsRegular.copyWith(
                            color: isSuccess ? successColor : iconDanger,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/ic_close_circle.svg',
                    color: isSuccess ? successColor : iconDanger,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}