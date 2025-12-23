import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../color.dart';

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: black200),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Center(
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            'assets/images/ic_bottom_sheet_close.svg',
            height: 16,
            width: 16,
          ),
        ),
      ),
    );
  }
}
