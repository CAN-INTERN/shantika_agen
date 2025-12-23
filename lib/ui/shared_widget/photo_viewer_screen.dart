import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../color.dart';
import '../dimension.dart';

class PhotoViewerScreen extends StatefulWidget {
  final int initialIndex;
  final List<String> listImageUrl;

  const PhotoViewerScreen({
    Key? key,
    required this.listImageUrl,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  int _current = 0;

  @override
  void initState() {
    _current = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "${_current + 1}/${widget.listImageUrl.length}",
        ),
      ),
      body: PhotoViewGallery.builder(
        itemCount: widget.listImageUrl.length,
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
              widget.listImageUrl[index],
            ),
          );
        },
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
    );
  }
}

class NestGymCardSelected extends StatelessWidget {
  final Widget child;
  final bool? isSelected;

  const NestGymCardSelected({
    Key? key,
    required this.child,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxBorder border = Border.all(width: 1, color: isSelected ?? false ? successColor : primaryColor);

    Widget contentChild = isSelected ?? false
        ? Stack(
            children: [
              child,
              Positioned(
                top: spacing4,
                right: spacing4,
                child: FaIcon(
                  FontAwesomeIcons.circleCheck,
                  size: 16,
                  color: successColor,
                ),
              ),
            ],
          )
        : child;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(spacing4),
        border: border,
        color: primaryColor,
      ),
      child: contentChild,
    );
  }
}
