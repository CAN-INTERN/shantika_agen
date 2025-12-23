import 'package:flutter/material.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/dimension.dart';
import 'package:shantika_agen/ui/typography.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final Color? lineColor;
  final TextStyle? textStyle;
  final double? lineWidth;
  final double? lineHeight;
  final BorderRadiusGeometry? lineRadius;

  const SectionTitle({
    Key? key,
    required this.title,
    this.lineColor,
    this.textStyle,
    this.lineWidth,
    this.lineHeight,
    this.lineRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: space150,
      ),
      child: Row(
        children: [
          Container(
            width: lineWidth ?? 4,
            height: lineHeight ?? 24,
            decoration: BoxDecoration(
              color: lineColor ?? navy400,
              borderRadius: lineRadius ?? BorderRadius.circular(0),
            ),
          ),
          SizedBox(width: space150),
          Text(
            title,
            style: textStyle ?? smSemiBold,
          ),
        ],
      ),
    );
  }
}