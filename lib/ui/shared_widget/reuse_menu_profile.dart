import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:with_space_between/with_space_between.dart';

import '../color.dart';
import '../dimension.dart';
import '../typography.dart';

class ReuseMenuProfile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;
  const ReuseMenuProfile(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap,
      this.isLogout = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: space300, vertical: space300),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 22,
              width: 22,
              color: isLogout ? iconPrimary : iconDarkPrimary,
            ),
            Text(
              title,
              style: smMedium.copyWith(color: isLogout ? textPrimary : textDarkPrimary),
            ),
          ].withSpaceBetween(width: space200),
        ),
      ),
    );
  }
}
