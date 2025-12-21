import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_mikufans/entity/episode.dart';
import 'package:mobile_mikufans/service/api.dart';
import 'package:mobile_mikufans/ui/component/cap_video_player.dart';

import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  bool _isFullScreen = false;
  String msg = "";
  int episodeIndex = 0;
  Episode? episode;
  final VideoPlayerController _controller = VideoPlayerController.networkUrl(
    Uri.parse(
      'https://ggkkmuup9wuugp6ep8d.exp.bcevod.com/mda-qj5xmkg7sm2wq7yd/navideo720/mda-qj5xmkg7sm2wq7yd.mp4?Expires=1766289942&AccessKeyId=mK9561BJY4s7Ux20&Signature=6992c130c0c55a82e8f5c95086e42151',
    ),
  );
  late final TabController _tabController = TabController(
    vsync: this,
    length: 2,
  );
  void _fetchEpisode() async {
    final res = await Api.bangumi.fethcEpisodeSync(
      184840,
      (e) => setState(() {
        log(e.toString());
        msg = e.toString();
      }),
    );
    setState(() {
      episode = res;
    });
  }

  void _onEpisodeSelected(int index) {
    setState(() {
      episodeIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchEpisode();
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
        backgroundColor: _isFullScreen ? Colors.black : null,
        body: SafeArea(
          child: _isFullScreen
              ? Center(
                  child: AspectRatio(
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
                )
              : Column(
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
                                  child: episode != null
                                      ? GridView.builder(
                                          itemCount: episode!.data?.length,
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
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              selected: episodeIndex == index,
                                              onTap: () {
                                                _onEpisodeSelected(index);
                                              },
                                              subtitle: Text(
                                                episode!.data?[index].nameCn ??
                                                    "暂无剧集名称",
                                              ),
                                              title: Text(
                                                (index + 1).toString(),
                                              ),
                                            );
                                          },
                                        )
                                      : Center(child: Text("暂无剧集")),
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
