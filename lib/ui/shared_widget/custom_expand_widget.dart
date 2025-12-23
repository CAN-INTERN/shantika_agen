import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:with_space_between/with_space_between.dart';

// import '../../features/faq/detail_faq_screen.dart';
import '../color.dart';
import '../dimension.dart';
import '../typography.dart';

class CustomExpandWidget extends StatefulWidget {
  const CustomExpandWidget(
      {super.key, required this.titleSection, required this.itemViewList});
  final List<Widget> itemViewList;
  final String titleSection;

  @override
  State<CustomExpandWidget> createState() => _CustomExpandWidgetState();
}

class _CustomExpandWidgetState extends State<CustomExpandWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: Container(
        // margin: const EdgeInsets.only(bottom: space300),
        padding: const EdgeInsets.all(space400),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius300),
          color: bg,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
          // border: Border.all(color: borderNeutralDark)
        ),
        child: Column(
          children: [
            Row(
              children: [
                FaIcon(
                  _expanded
                      ? FontAwesomeIcons.chevronUp
                      : FontAwesomeIcons.chevronDown,
                  color: iconDarkPrimary,
                  size: 16,
                ),
                Expanded(
                  child: Text(
                    widget.titleSection,
                    style: smRegular.copyWith(color: textDarkPrimary),
                  ),
                ),
              ].withSpaceBetween(width: space300),
            ),
            if (_expanded) ...[
              const SizedBox(height: space200),
              const Divider(color: borderNeutralLight),
              const SizedBox(height: space300),
              InkWell(
                onTap: (){
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const DetailFaqScreen(),
                  //   ),
                  // );
                },
                child: ListView(
                  children: widget.itemViewList,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
