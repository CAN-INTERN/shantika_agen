import 'package:flutter/material.dart';

import '../color.dart';
import '../dimension.dart';
import '../typography.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    this.titleSection,
    this.titleSectionWidget, // ✅ Tambahin ini
    required this.child,
    this.helperText,
    this.helper,
  });

  final String? titleSection;
  final Widget? titleSectionWidget; // ✅ Tambahin ini
  final Widget? helper;
  final String? helperText;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (titleSectionWidget != null)
          titleSectionWidget!
        else if (titleSection != '')
          Text(
            titleSection ?? '',
            style: smMedium.copyWith(fontWeight: FontWeight.w500),
          ),
        SizedBox(height: space300),
        child,
        helper != null || helperText != null
            ? const SizedBox(height: 6)
            : const SizedBox(),
        _generateHelper(),
      ],
    );
  }

  Widget _generateHelper() {
    const textStyle = TextStyle(
      color: textNeutralSecondary,
      fontSize: 12,
      height: 0.8,
    );

    if (helper != null) {
      return DefaultTextStyle.merge(
        style: textStyle,
        child: helper!,
      );
    } else {
      return Text(helperText ?? "", style: textStyle);
    }
  }
}
