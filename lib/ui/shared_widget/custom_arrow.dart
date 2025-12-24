import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../color.dart';
import '../typography.dart';

class CustomArrow extends StatelessWidget {
  final String? title;
  final VoidCallback? onBack;
  final Color iconColor;
  final Color textColor;
  final TextStyle? titleStyle;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final double iconSize;

  const CustomArrow({
    Key? key,
    this.title,
    this.onBack,
    this.iconColor = black950,
    this.textColor = black950,
    this.titleStyle,
    this.suffixIcon,
    this.padding,
    this.iconSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
            left: 10,
            top: 30,
            right: 30,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onBack ?? () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: iconColor,
                  size: iconSize,
                ),
              ),
              if (title != null) ...[
                SizedBox(width: 6),
                Text(
                  title!,
                  style: titleStyle ?? xlSemiBold.copyWith(color: textColor),
                ),
              ],
            ],
          ),
          if (suffixIcon != null) suffixIcon!,
        ],
      ),
    );
  }
}