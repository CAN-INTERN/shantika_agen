import 'package:flutter/material.dart';

import '../color.dart';
import '../typography.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool leading;
  final String title;
  final Color color;
  final bool centerTitle;
  const CommonAppbar(
      {super.key,
      required this.leading,
      required this.title,
      this.color = bg,
      this.centerTitle = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      surfaceTintColor: color,
      automaticallyImplyLeading: leading,
      elevation: null,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: xlMedium.copyWith(color: textDarkPrimary),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
