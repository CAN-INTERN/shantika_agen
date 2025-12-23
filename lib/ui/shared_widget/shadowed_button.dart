import 'package:flutter/material.dart';

import '../color.dart';
import '../dimension.dart';
import '../typography.dart';

class ShadowedButton extends StatelessWidget {
  final Function()? onPressed;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final bool disabled;
  const ShadowedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.disabled = false,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: disabled || onPressed == null
            ? null
            : [
                BoxShadow(
                  color: black950.withOpacity(0.15), // 15% opacity
                  spreadRadius: 0,
                  blurRadius: 32,
                  offset: Offset(0, 8), // shadow ke bawah
                ),
                // BoxShadow(
                //   color: Color(0xffB5B5B5),
                //   spreadRadius: 0,
                //   blurRadius: 0,
                //   offset: Offset(0, 1), // changes position of shadow
                // ),
                // BoxShadow(
                //   color: Color(0xffE3E3E3),
                //   spreadRadius: 0,
                //   blurRadius: 0,
                //   offset: Offset(1, 0), // changes position of shadow
                // ),
                // BoxShadow(
                //   color: Color(0xffE3E3E3),
                //   spreadRadius: 0,
                //   blurRadius: 0,
                //   offset: Offset(-1, 0), // changes position of shadow
                // ),
                // BoxShadow(
                //   color: Color(0xffE3E3E3),
                //   spreadRadius: 0,
                //   blurRadius: 0,
                //   offset: Offset(0, -1), // changes position of shadow
                // ),
              ],
        borderRadius: BorderRadius.circular(borderRadius300),
      ),
      child: Material(
        color: disabled || onPressed == null ? black200 : bgButtonOutlinedDefault,
        borderRadius: BorderRadius.circular(borderRadius300),
        child: InkWell(
          splashColor: bgButtonOutlinedPressed,
          borderRadius: BorderRadius.circular(borderRadius300),
          onTap: onPressed,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius300),
              color: backgroundColor != null
                  ? backgroundColor!
                  : (disabled ? backgroundColor : transparentColor) ?? Colors.transparent,
            ),
            padding: padding ?? EdgeInsets.symmetric(horizontal: paddingXL, vertical: paddingS),
            child: DefaultTextStyle.merge(
                style: xsSemiBold,
                textAlign: TextAlign.center,
                child: Center(child: child)),
          ),
        ),
      ),
    );
  }
}
