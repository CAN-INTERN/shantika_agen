import 'package:flutter/material.dart';
import '../dimension.dart';
import '../typography.dart';

class EmptyView extends StatelessWidget {
  final String? image;
  final String? title;
  final String? description;
  final Widget? action;
  final double? imageSize;
  final double? imageWidth;
  const EmptyView({
    super.key,
    this.image = "assets/images/img_empty_404.png",
    this.title = "Sedikit Kosong Disini",
    this.imageSize = 96,
    this.imageWidth = 96,
    this.description = "Kami akan menata ruang ini segera",
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: spacing4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: image != null,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFF9999).withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  image ?? "",
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Visibility(
              visible: title != null,
              child: Padding(
                padding: const EdgeInsets.only(top: spacing2),
                child: Text(
                  title ?? "",
                  style: sMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Visibility(
              visible: description != null,
              child: Padding(
                padding: const EdgeInsets.only(top: spacing2),
                child: Text(
                  description ?? "",
                  style: xsRegular,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Visibility(
              visible: action != null,
              child: Padding(
                padding: const EdgeInsets.only(top: spacing2),
                child: action,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
