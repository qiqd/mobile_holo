import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class CapVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  final String? title;
  final bool isFullScreen;
  final Function(bool)? onFullScreenChanged;
  const CapVideoPlayer({
    super.key,
    required this.controller,
    this.isFullScreen = false,
    this.title = "暂无标题",
    this.onFullScreenChanged,
  });

  @override
  State<CapVideoPlayer> createState() => _CapVideoPlayerState();
}

class _CapVideoPlayerState extends State<CapVideoPlayer> {
  late bool _isFullScreen = widget.isFullScreen;
  late final String title = widget.title ?? "暂无标题";
  late final VideoPlayerController player = widget.controller;
  double videoDuration = 0.0;
  double videoPosition = 0.0;
  double bufferedEnd = 0.0;
  double aspectRatio = 16 / 9;
  bool isPlaying = false;
  bool isBuffering = false;
  String msgText = '';
  bool showMsg = false;
  Duration? _dragStartPosition;
  double _totalDragOffset = 0.0;
  bool isForward = true;
  void _toggleFullScreen() async {
    if (_isFullScreen) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    widget.onFullScreenChanged?.call(_isFullScreen);
  }

  void _handleHorizontalDragStart(DragStartDetails details) {
    _dragStartPosition = player.value.position;
    _totalDragOffset = 0.0;
    setState(() {
      showMsg = true;
    });
  }

  void _handleHorizontalDragUpdate(DragUpdateDetails details) {
    _totalDragOffset += details.delta.dx;
    setState(() {
      isForward = details.delta.dx > 0;
    });
    final RenderBox box = context.findRenderObject() as RenderBox;
    final width = box.size.width;
    final jumpMs = (_totalDragOffset / width * 90 * 1000).round();

    String direction = jumpMs > 0 ? '快进' : '快退';
    int absSeconds = (jumpMs.abs() / 1000).round();

    setState(() {
      msgText = '$direction ${absSeconds}s';
    });
  }

  // 结束拖动：执行 seek 并隐藏提示
  void _handleHorizontalDragEnd(DragEndDetails details) async {
    if (_dragStartPosition == null) return;

    final RenderBox box = context.findRenderObject() as RenderBox;
    final width = box.size.width;

    final jumpMs = (_totalDragOffset / width * 90 * 1000).round();
    final newPosition = (_dragStartPosition!.inMilliseconds + jumpMs).clamp(
      0,
      player.value.duration.inMilliseconds,
    );

    await player.seekTo(Duration(milliseconds: newPosition));

    // 隐藏提示
    setState(() {
      showMsg = false;
      msgText = '';
    });

    // 清理状态
    _dragStartPosition = null;
    _totalDragOffset = 0.0;
  }

  void _addListener() {
    player.addListener(() {
      if (player.value.hasError) {
        print("播放器发生错误: ${player.value.errorDescription}");
      }
      if (mounted) {
        setState(() {
          videoPosition = player.value.position.inSeconds.toDouble();
          bufferedEnd = getBufferedEnd();
          videoDuration = player.value.duration.inSeconds.toDouble();
          isPlaying = player.value.isPlaying;
          isBuffering = player.value.isBuffering;
          aspectRatio = player.value.aspectRatio;
        });
      }
    });
  }

  double getBufferedEnd() {
    final buffered = widget.controller.value.buffered;
    if (buffered.isEmpty) return 0.0;

    Duration maxEnd = buffered.first.end;
    for (var range in buffered) {
      if (range.end > maxEnd) {
        maxEnd = range.end;
      }
    }
    return maxEnd.inSeconds.toDouble();
  }

  @override
  void initState() {
    _addListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isFullScreen,
      onPopInvokedWithResult: (didPop, result) {
        if (_isFullScreen) {
          setState(() {
            _isFullScreen = false;
          });
          _toggleFullScreen();
        } else if (!didPop) {
          context.pop();
        }
      },
      child: Stack(
        children: [
          player.value.isInitialized
              ? VideoPlayer(player)
              : SizedBox(child: Center(child: CircularProgressIndicator())),
          if (showMsg) ...[
            Align(
              alignment: Alignment.center,
              child: Text(msgText, style: TextStyle(color: Colors.white)),
            ),
          ],
          GestureDetector(
            onHorizontalDragStart: _handleHorizontalDragStart,
            onHorizontalDragUpdate: _handleHorizontalDragUpdate,
            onHorizontalDragEnd: _handleHorizontalDragEnd,
            onDoubleTap: () =>
                player.value.isPlaying ? player.pause() : player.play(),

            child: Container(color: Colors.transparent),
          ),

          Column(
            children: [
              Row(
                children: [
                  // 返回
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      if (_isFullScreen) {
                        setState(() {
                          _isFullScreen = false;
                        });
                        _toggleFullScreen();
                      } else {
                        context.pop();
                      }
                    },
                  ),
                  // 标题
                  Text(
                    title,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Colors.white),
                  ),
                  Spacer(),
                  _isFullScreen
                      ? Text(
                          "${DateTime.now().hour}:${DateTime.now().minute}",
                          style: TextStyle(color: Colors.white),
                        )
                      : Container(),
                ],
              ),
              Expanded(child: Container()),
              // 进度条
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      secondaryTrackValue: getBufferedEnd(),
                      value: widget.controller.value.position.inSeconds
                          .toDouble(),
                      max: widget.controller.value.duration.inSeconds
                          .toDouble(),
                      onChangeEnd: (value) {
                        setState(() {
                          widget.controller.seekTo(
                            Duration(seconds: value.toInt()),
                          );
                          widget.controller.play();
                        });
                      },
                      onChanged: (value) {
                        // setState(() {
                        //   widget.controller.seekTo(
                        //     Duration(seconds: value.toInt()),
                        //   );
                        // });
                      },
                    ),
                  ),
                ],
              ),
              // 播放按钮
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (widget.controller.value.isPlaying) {
                        widget.controller.pause();
                      } else {
                        widget.controller.play();
                      }
                      setState(() {});
                    },
                    icon: Icon(
                      widget.controller.value.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                    ),
                  ),
                  // 下一集
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.skip_next_rounded, color: Colors.white),
                  ),
                  if (!_isFullScreen) ...[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.format_list_bulleted_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  //进度
                  Text(
                    "${widget.controller.value.position.inMinutes}:${widget.controller.value.position.inSeconds.remainder(60)}",
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Text('弹', style: TextStyle(color: Colors.white)),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isFullScreen = !_isFullScreen;
                      });
                      _toggleFullScreen();
                    },
                    icon: Icon(
                      _isFullScreen
                          ? Icons.fullscreen_exit_rounded
                          : Icons.fullscreen_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
