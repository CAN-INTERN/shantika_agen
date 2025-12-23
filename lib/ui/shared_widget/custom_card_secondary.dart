import 'package:flutter/material.dart';

import '../color.dart';

// ignore: must_be_immutable
class CustomCardSecondary extends StatelessWidget {
  CustomCardSecondary({super.key, required this.child, this.leftColor, this.useShadow});

  final Widget child;
  final Color? leftColor;
  final bool? useShadow;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: borderNeutral.withOpacity(0.03), // Shadow dark
              offset: Offset(0, 10),
              blurRadius: 15, // Blur radius 15px sesuai Figma
              spreadRadius: 0, // Tidak ada spread, cuma blur
            ),
          ],
          border: Border(
            left: BorderSide(
              color: leftColor ?? const Color(0xFFD83C15),
              width: 3,
            ),
          ),
        ),
        child: Stack(
          children: [
            // Radial gradient background
            Visibility(
              visible: useShadow ?? false,
              child: Positioned(
                top: -60,
                left: -90,
                child: Container(
                  width: 239,
                  height: 239,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      center: Alignment.center,
                      colors: [
                        Color(0x0FFFA100), // 6% opacity
                        Color(0x00FFA100), // 0% opacity
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Content
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity,
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
