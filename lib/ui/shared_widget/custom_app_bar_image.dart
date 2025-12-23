import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../color.dart';
import '../dimension.dart';
import '../typography.dart';

class CustomAppBarImage extends StatelessWidget implements PreferredSizeWidget {
  final bool leading;
  final String title;
  final Color color;
  final bool centerTitle;
  final String img;
  const CustomAppBarImage(
      {super.key,
      required this.leading,
      required this.title,
      this.color = bg,
      this.centerTitle = false,
      required this.img});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      surfaceTintColor: color,
      automaticallyImplyLeading: leading,
      elevation: null,
      centerTitle: centerTitle,
      leading: Padding(
        padding: const EdgeInsets.only(top: space300, bottom: space300, left: space300),
        child: Container(
          // color: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: space200, vertical: space200),
          child: SvgPicture.asset(img),
        ),
      ),
      title: Text(
        title,
        style: xlMedium.copyWith(color: textDarkPrimary),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
