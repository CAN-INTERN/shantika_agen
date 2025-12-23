import 'package:flutter/material.dart';

import '../color.dart';

// ignore: must_be_immutable
class CustomSwitch extends StatefulWidget {
  CustomSwitch({super.key, required this.value, this.onChanged});

  bool value;
  void Function(bool)? onChanged;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      activeColor: primaryColor,
      applyCupertinoTheme: false,
      value: widget.value,
      onChanged: widget.onChanged,
    );
  }
}
