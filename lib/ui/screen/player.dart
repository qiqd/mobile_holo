import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_mikufans/entity/episode.dart';
import 'package:mobile_mikufans/entity/media.dart';
import 'package:mobile_mikufans/entity/subject.dart';
import 'package:mobile_mikufans/service/api.dart';
import 'package:mobile_mikufans/service/source_service.dart';
import 'package:mobile_mikufans/service/util/jaro_winkler_similarity.dart';
import 'package:mobile_mikufans/ui/component/cap_video_player.dart';
import 'package:mobile_mikufans/ui/component/loading_msg.dart';

import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  final String mediaId;
  final int subjectId;
  final SourceService source;
  final String nameCn;
  const PlayerScreen({
    super.key,
    required this.mediaId,
    required this.subjectId,
    required this.source,
    required this.nameCn,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  bool _isFullScreen = false;
  String msg = "";
  int episodeIndex = 0;
  int lineIndex = 0;
  Episode? _episode;
  Detail? _detail;
  bool isloading = false;
  Data? subject;
  late final String nameCn = widget.nameCn;
  late final String mediaId = widget.mediaId;
  late final SourceService source = widget.source;
  VideoPlayerController? _controller;

  late final TabController _tabController = TabController(
    vsync: this,
    length: 2,
  );
  Future<void> _fetchMediaEpisode() async {
    isloading = true;
    try {
      final res = await source.fetchDetail(
        mediaId,
        (e) => setState(() {
          msg = e.toString();
        }),
      );
      setState(() {
        _detail = res;
      });
    } catch (e) {
      setState(() {
        msg = e.toString();
      });
    } finally {
      isloading = false;
    }
  }

  void _fetchViewInfo() async {
    isloading = true;
    try {
      if (_detail != null) {
        final newUrl = await source.fetchView(
          _detail!.lines![lineIndex].episodes![episodeIndex],
          (e) => setState(() {
            msg = e.toString();
          }),
        );
        if (mounted) {
          setState(() {
            _controller = VideoPlayerController.networkUrl(Uri.parse(newUrl!));
            _controller?.initialize().then((_) {
              setState(() {});
              _controller?.play();
            });
          });
        }
      }
    } catch (e) {
      setState(() {
        msg = e.toString();
      });
    } finally {
      isloading = false;
    }
  }

  void _onLineSelected(int index) {
    setState(() {
      lineIndex = index;
    });
  }

  void _onEpisodeSelected(int index) {
    setState(() {
      episodeIndex = index;
    });
    _fetchViewInfo();
  }

  void _fetchEpisode() async {
    final newSubject = await Api.bangumi.fetchSearchSync(nameCn, (e) {
      setState(() {
        msg = e.toString();
      });
    });
    var data = newSubject!.data ?? [];
    data = data.where((s) => s.nameCn != null).toList();
    final name2IdMap = {for (final item in data) item.nameCn!: item.id!};
    final rs = {
      for (final item in name2IdMap.entries)
        JaroWinklerSimilarity.apply(nameCn, item.key): item.value,
    };
    final maxScore = rs.keys.reduce((a, b) => a.compareTo(b) > 0 ? a : b);
    final subjectId = rs[maxScore];
    subject = newSubject.data?.firstWhere((s) => s.id == subjectId);
    final res = await Api.bangumi.fethcEpisodeSync(
      subjectId!,
      (e) => setState(() {
        log(e.toString());
        msg = e.toString();
      }),
    );
    setState(() {
      _episode = res;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchEpisode();
    _fetchMediaEpisode().then((value) => _fetchViewInfo());
  }

  @override
  void dispose() {
    _controller?.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        backgroundColor: _isFullScreen ? Colors.black : null,
        body: SafeArea(
          child: _isFullScreen
              ? Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: _controller != null
                        ? CapVideoPlayer(
                            title: widget.nameCn,
                            isloading: isloading,
                            controller: _controller!,
                            isFullScreen: _isFullScreen,
                            onFullScreenChanged: (isFullScreen) {
                              setState(() {
                                _isFullScreen = isFullScreen;
                              });
                            },
                          )
                        : LoadingOrShowMsg(msg: msg),
                  ),
                )
              : Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: _controller != null
                          ? CapVideoPlayer(
                              title: widget.nameCn,
                              isloading: isloading,
                              controller: _controller!,
                              isFullScreen: _isFullScreen,
                              onFullScreenChanged: (isFullScreen) {
                                setState(() {
                                  _isFullScreen = isFullScreen;
                                });
                              },
                            )
                          : LoadingOrShowMsg(msg: msg),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            controller: _tabController,
                            tabs: [
                              Tab(text: "评论"),
                              Tab(text: "选集"),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                Container(),
                                Container(
                                  child: GridView.builder(
                                    itemCount: _episode?.data?.length,
                                    padding: EdgeInsets.all(6),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 6,
                                          crossAxisSpacing: 6,
                                          crossAxisCount: 3,
                                          childAspectRatio: 1.6,
                                        ),
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        selected: episodeIndex == index,
                                        onTap: () {
                                          _onEpisodeSelected(index);
                                        },
                                        subtitle: Text(
                                          _episode?.data?[index].nameCn ??
                                              "暂无剧集名称",
                                        ),
                                        title: Text((index + 1).toString()),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
