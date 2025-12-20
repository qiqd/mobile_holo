import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_mikufans/ui/component/cap_video_player.dart';

import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _isFullScreen = false;
  final VideoPlayerController _controller = VideoPlayerController.networkUrl(
    Uri.parse(
      'https://ggkkmuup9wuugp6ep8d.exp.bcevod.com/mda-qj5xmkg7sm2wq7yd/navideo720/mda-qj5xmkg7sm2wq7yd.mp4?Expires=1766243429&AccessKeyId=C86nif472huzbQHZ&Signature=28ff68de1820391ef3969cf0a89aed60',
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller.initialize().then((_) {
      setState(() {});

      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        body: SafeArea(
          child: _isFullScreen
              ? CapVideoPlayer(
                  title: "我推的孩子 第二季",
                  controller: _controller,
                  isFullScreen: _isFullScreen,
                  onFullScreenChanged: (isFullScreen) {
                    setState(() {
                      _isFullScreen = isFullScreen;
                    });
                  },
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CapVideoPlayer(
                          title: "我推的孩子 第二季",
                          controller: _controller,
                          isFullScreen: _isFullScreen,
                          onFullScreenChanged: (isFullScreen) {
                            setState(() {
                              _isFullScreen = isFullScreen;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
