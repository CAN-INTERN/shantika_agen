import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:with_space_between/with_space_between.dart';

import '../color.dart';
import '../dimension.dart';
import '../typography.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool leading;
  final String title;
  final Color color;
  final bool centerTitle;
  final String img;
  const CustomAppBar(
      {super.key,
      required this.leading,
      required this.title,
      this.color = bg,
      this.centerTitle = false, required this.img});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      surfaceTintColor: color,
      automaticallyImplyLeading: leading,
      elevation: null,
      centerTitle: centerTitle,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            img,
            color: iconDarkPrimary,
            height: 27,
            fit: BoxFit.fitHeight,
          ),
          Text(
            title,
            style: xlMedium.copyWith(color: textDarkPrimary),
          ),
        ].withSpaceBetween(width: space200),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
