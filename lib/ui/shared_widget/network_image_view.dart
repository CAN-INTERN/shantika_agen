import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NetworkImageView extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final String? errorFile;
  final BoxFit? fit;
  final double? radius;
  const NetworkImageView(
      {super.key, required this.url, this.width, this.height, this.errorFile, this.fit, this.radius});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      memCacheHeight: 400,
      // placeholder: (context, url) => const Center(
      //   child: CircularProgressIndicator(),
      // ),
      errorWidget: (context, url, error) => ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 12),
        child: SizedBox(
          width: double.infinity,
          child: SvgPicture.asset(
            "assets/images/img_error_illustration.svg",
          ),
        ),
      ),
    );
  }
}
