import 'package:flutter/material.dart';

class TransparentStatusBar extends StatelessWidget {
  final Widget child;
  const TransparentStatusBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.viewPaddingOf(context).top;
    return Stack(
      children: [
        Positioned(
          top: 0,left: 0,right: 0,
          child: Container(
            color: Colors.white.withOpacity(1),
            height: statusBarHeight,
            width: double.infinity,
          ),
        ),
        child
      ],
    );
  }
}
