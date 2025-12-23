import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_holo/entity/subject.dart';
import 'package:mobile_holo/service/api.dart';
import 'package:mobile_holo/ui/component/media_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Subject? _recommended;
  bool _loading = false;
  void _fetchSearch(String keyword, BuildContext context) async {
    setState(() {
      _loading = true;
    });
    final result = await Api.bangumi.fetchSearchSync(keyword, (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('搜索出错: ${e.toString()}')));
    });
    setState(() {
      _loading = false;
      _recommended = result;
    });
  }

  void _fetchRecommended() async {
    final recommended = await Api.bangumi.fetchRecommendSync(1, 20, (e) {});
    setState(() {
      _recommended = recommended;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchRecommended();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          child: Row(
            children: [
              Text("推荐"),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    onSubmitted: (value) {
                      _fetchSearch(value, context);
                    },
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: "搜索动漫、电影...",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          if (_loading) LinearProgressIndicator(),
          Expanded(
            child: Center(
              child: _recommended == null
                  ? Text("暂无推荐")
                  : GridView.builder(
                      itemCount: _recommended!.data!.length,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 6,
                            crossAxisCount: 3,
                            childAspectRatio: 0.6,
                          ),
                      itemBuilder: (context, index) {
                        final item = _recommended!.data![index];
                        return MediaGrid(
                          id: item.id!,
                          imageUrl: item.images?.medium,
                          title: item.nameCn!.isEmpty
                              ? item.name ?? ""
                              : item.nameCn,
                          rating: item.rating?.score,
                          onTap: () {
                            context.push(
                              '/detail',
                              extra: {
                                'id': item.id!,
                                'keyword': item.nameCn ?? item.name ?? "",
                              },
                            );
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
