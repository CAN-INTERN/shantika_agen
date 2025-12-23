import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../color.dart';
import '../typography.dart';

class CustomArrow extends StatelessWidget {
  final String? title;
  final VoidCallback? onBack;
  final Color iconColor;
  final Color textColor;
  final Widget? suffixIcon;

  const CustomArrow({
    Key? key,
    this.title,
    this.onBack,
    this.iconColor = black950,
    this.textColor = black950,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
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
                  size: 18,
                ),
              ),
              if (title != null) ...[
                SizedBox(width: 6),
                Text(title!, style: xlSemiBold),
              ],
            ],
          ),
          if (suffixIcon != null) suffixIcon!,
        ],
      ),
    );
  }
}