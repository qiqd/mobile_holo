import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_holo/entity/history.dart';
import 'package:mobile_holo/service/util/local_store.dart';
import 'package:mobile_holo/ui/component/loading_msg.dart';
import 'package:mobile_holo/ui/component/media_grid.dart';
import 'package:mobile_holo/ui/component/meida_card.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen>
    with SingleTickerProviderStateMixin, RouteAware {
  List<History> histories = [];
  List<History> subscribe = [];

  late final TabController _tabController = TabController(
    vsync: this,
    length: 2,
  );
  @override
  void initState() {
    super.initState();
    histories = LocalStore.gerAllHistory();
    subscribe = histories.where((history) => history.isLove).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('订阅')),
      body: VisibilityDetector(
        key: const Key('subscribe_screen'),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction > 0) {
            histories = LocalStore.gerAllHistory();
            subscribe = histories.where((history) => history.isLove).toList();
            setState(() {});
          }
        },
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: '订阅'),
                Tab(text: '历史记录'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  subscribe.isEmpty
                      ? LoadingOrShowMsg(msg: '暂无订阅')
                      : GridView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: subscribe.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 6,
                                childAspectRatio: 0.6,
                              ),
                          itemBuilder: (context, index) {
                            return MediaGrid(
                              showRating: false,
                              id: subscribe[index].id,
                              imageUrl: subscribe[index].imgUrl,
                              title: subscribe[index].title,
                              onTap: () => context.push(
                                '/detail',
                                extra: {
                                  "id": subscribe[index].id,
                                  "keyword": subscribe[index].title,
                                },
                              ),
                            );
                          },
                        ),
                  histories.isEmpty
                      ? LoadingOrShowMsg(msg: '暂无历史记录')
                      : ListView.separated(
                          padding: const EdgeInsets.all(8),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: histories.length,
                          itemBuilder: (context, index) {
                            return MeidaCard(
                              height: 190,
                              lastViewAt: histories[index].lastViewAt,
                              historyEpisode: histories[index].episodeIndex,
                              id: histories[index].id,
                              imageUrl: histories[index].imgUrl,
                              nameCn: histories[index].title,
                              onTap: () => context.push(
                                '/detail',
                                extra: {
                                  "id": histories[index].id,
                                  "keyword": histories[index].title,
                                },
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
