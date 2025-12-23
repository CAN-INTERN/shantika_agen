import 'package:flutter/material.dart';
import '../color.dart';
import '../dimension.dart';
import '../typography.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool disabled;
  final Gradient? gradient;
  final Color textColor;
  final Color textColorDisabled;
  final Size? maximumSize;
  final Color backgroundColor;
  final Color disabledColor;
  final Size? minimumSize;
  final Border? border;
  final Color? borderColor;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const CustomButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.disabled = false,
    this.gradient,
    this.textColor = textButtonPrimary,
    this.textColorDisabled = textDisabled,
    this.maximumSize,
    this.minimumSize,
    this.backgroundColor = bgButtonInfoPressed,
    this.border,
    this.borderColor,
    this.disabledColor = bgDisabled,
    this.width,
    this.padding,
    this.borderRadius = borderRadius300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 32,
        minWidth: 0,
      ),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: border ??
              (borderColor != null
                  ? Border.all(
                color: borderColor!,
                width: 1,
              )
                  : null),
        ),
        child: Material(
          color: onPressed != null ? backgroundColor : disabledColor,
          borderRadius: BorderRadius.circular(borderRadius),
          child: InkWell(
            splashColor: transparentColor,
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: onPressed != null
                ? () {
              FocusManager.instance.primaryFocus?.unfocus();
              onPressed!();
            }
                : null,
            child: Center(
              child: Padding(
                padding: padding ??
                    const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                child: DefaultTextStyle.merge(
                  style: smBold.copyWith(
                    color: onPressed != null ? textColor : textColorDisabled,
                  ),
                  textAlign: TextAlign.center,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
