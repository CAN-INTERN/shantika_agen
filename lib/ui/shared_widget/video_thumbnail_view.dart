import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shantika_agen/ui/shared_widget/video_player_screen.dart';
import 'package:video_player/video_player.dart';

import '../color.dart';

class VideoThumbnailView extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;

  const VideoThumbnailView({super.key, required this.url, this.width, this.height});

  @override
  State<VideoThumbnailView> createState() => _VideoThumbnailViewState();
}

class _VideoThumbnailViewState extends State<VideoThumbnailView> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller != null
        ? GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerScreen(videoUrl: widget.url)));
            },
            child: Container(
              width: widget.width,
              height: widget.height,
              child: Stack(
                children: [
                  VideoPlayer(_controller!),
                  Container(
                    width: widget.width,
                    height: widget.height,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.play,
                        size: 20,
                        color: iconWhite,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : CircularProgressIndicator();
  }
}
