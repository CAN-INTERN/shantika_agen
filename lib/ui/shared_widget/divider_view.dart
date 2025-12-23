import 'package:flutter/material.dart';

import '../color.dart';
import '../dimension.dart';

class DividerView extends StatelessWidget {
  DividerView({super.key, this.height, this.verticalPadding});

  final double? height;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding ?? space400),
      child: Container(
        width: double.infinity,
        height: height ?? 3,
        color: borderNeutral,
      ),
    );
  }
}
