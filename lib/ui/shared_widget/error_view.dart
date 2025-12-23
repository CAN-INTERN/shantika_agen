import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shantika_agen/ui/shared_widget/custom_button.dart';
import 'package:with_space_between/with_space_between.dart';

import '../color.dart';
import '../dimension.dart';
import '../typography.dart';

class ErrorView extends StatelessWidget {
  final String title;
  final String desc;
  final String? img;
  final void Function()? onReload;

  const ErrorView({
    super.key,
    required this.title,
    required this.desc,
    this.img,
    this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          img ?? 'assets/images/img_error_illustration.svg',
          height: 180,
          width: 180,
        ),
        Text(
          title,
          style: smSemiBold.copyWith(color: textDarkPrimary),
        ),
        Text(
          desc,
          style: xsRegular.copyWith(color: textDarkPrimary),
          textAlign: TextAlign.center,
        ),
        CustomButton(
          backgroundColor: bgFillPrimary,
          onPressed: onReload,
          child: Text(
            "Muat Ulang",
            style: smMedium.copyWith(color: textLightPrimary),
          ),
        )
      ].withSpaceBetween(height: space500),
    );
  }
}
