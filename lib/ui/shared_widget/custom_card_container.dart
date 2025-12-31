import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:shantika_agen/ui/color.dart';

import '../dimension.dart';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shantika_agen/ui/color.dart';

import '../dimension.dart';
import '../typography.dart';

class CustomCardContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Gradient? gradient;
  final double borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? borderColor;
  final double? borderWidth;
  final bool isDashed;
  final double dashLength;
  final double dashGap;

  final Color? statusColor;
  final String? statusText;
  final Color? statusTextColor;
  final String? statusIcon;

  final VoidCallback? onTap;

  const CustomCardContainer({
    super.key,
    this.child,
    this.padding,
    this.backgroundColor,
    this.gradient,
    this.borderRadius = borderRadius100,
    this.border,
    this.boxShadow,
    this.margin,
    this.width,
    this.height,
    this.borderColor,
    this.borderWidth = 1.0,
    this.isDashed = false,
    this.dashLength = 5.0,
    this.dashGap = 3.0,
    this.statusColor,
    this.statusText,
    this.statusTextColor,
    this.statusIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(paddingL),
      decoration: BoxDecoration(
        color: gradient == null ? (backgroundColor ?? black00) : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border ??
            (borderColor != null
                ? Border.all(color: borderColor!, width: borderWidth!)
                : null),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: black700_70.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
      ),
      child: child,
    );

    final card = isDashed
        ? DottedBorder(
      color: borderColor ?? black700_70,
      strokeWidth: borderWidth ?? 1.0,
      dashPattern: [dashLength, dashGap],
      borderType: BorderType.RRect,
      radius: Radius.circular(borderRadius),
      child: content,
    )
        : content;

    final stack = Stack(
      children: [
        card,
        if (statusText != null)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  if (statusIcon != null)
                    SvgPicture.asset(
                      statusIcon!,
                      height: 12,
                      width: 12,
                      colorFilter: ColorFilter.mode(
                        statusTextColor ?? Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  if (statusIcon != null) const SizedBox(width: 4),
                  Text(
                    statusText!,
                    style: xxsMedium.copyWith(
                      color: statusTextColor ?? Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );

    return Container(
      margin: margin,
      child: onTap != null
          ? Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: stack,
        ),
      )
          : stack,
    );
  }
}
