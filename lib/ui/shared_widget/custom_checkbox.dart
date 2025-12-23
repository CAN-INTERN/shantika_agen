import 'package:flutter/material.dart';

import '../color.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final double size;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.size = 24.0,
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged?.call(!widget.value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), // 4px border radius
          border: Border.all(
            color: widget.value
                ? iconSecondary // Border color when checked
                : borderNeutral, // Border color when unchecked
            width: 1,
          ),
          color: widget.value
              ? primaryColor // #B18D41 background when checked
              : Colors.white, // #0F0F0F background when unchecked
        ),
        child: widget.value
            ? Icon(
                Icons.check,
                size: 12,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
