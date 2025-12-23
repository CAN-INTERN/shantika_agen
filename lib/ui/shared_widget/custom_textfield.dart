import 'package:flutter/material.dart';

import '../color.dart';
import '../typography.dart';

class CustomTextfield extends StatelessWidget {
  final String text;
  final bool isIcon;
  final IconData icon;
  CustomTextfield({super.key, required this.isIcon, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: black200),
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          hintText: text,
          hintStyle: sMedium.copyWith(color: textNeutralSecondary),
          border: InputBorder.none,
          suffixIcon: isIcon ? Icon(icon, color: iconDarkSecondary) : null,
        ),
        style: sRegular.copyWith(color: textNeutralPrimary),
      ),
    );
  }
}
