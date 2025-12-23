import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../color.dart';
import '../typography.dart';

class CustomVerifikasiInfo extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool active;
  const CustomVerifikasiInfo({super.key, required this.text, required this.icon, required this.active});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        active ? FaIcon(FontAwesomeIcons.circleCheck,color: iconSuccess,) :
        Icon(
          icon,
          color: iconNeutralPrimary,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            text,
            style: sRegular.copyWith(color: active ? textSuccess: textNeutralSecondary),
          ),
        ),
      ],
    );
  }
}
