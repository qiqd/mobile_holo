import 'package:flutter/material.dart';
import 'package:mobile_mikufans/entity/character.dart';
import 'package:mobile_mikufans/entity/person.dart';
import 'package:mobile_mikufans/entity/subject.dart' show Data;
import 'package:mobile_mikufans/entity/subject_relation.dart';

import 'package:mobile_mikufans/service/api.dart';
import 'package:mobile_mikufans/ui/component/meida_card.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  Data? data;
  List<Person>? person;
  List<Character>? character;
  List<SubjectRelation>? relation;

  late TabController tabController = TabController(vsync: this, length: 4);
  String _msg = "";
  void _fetchSubjec() async {
    final res = await Api.bangumi.fetchSubjectSync(widget.id, (e) {
      setState(() {
        _msg = e.toString();
      });
    });
    setState(() {
      data = res;
    });
  }

  void _fetchPerson() async {
    final res = await Api.bangumi.fetchPersonSync(widget.id, (e) {
      setState(() {
        _msg = e.toString();
      });
    });
    setState(() {
      person = res;
    });
  }

  void _fetchCharacter() async {
    final res = await Api.bangumi.fetchCharacterSync(widget.id, (e) {
      setState(() {
        _msg = e.toString();
      });
    });
    setState(() {
      character = res;
    });
  }

  void _fetchRelation() async {
    final res = await Api.bangumi.fetchSubjectRelationSync(widget.id, (e) {
      setState(() {
        _msg = e.toString();
      });
    });
    setState(() {
      relation = res;
    });
  }

  @override
  void initState() {
    _fetchSubjec();
    _fetchPerson();
    _fetchCharacter();
    _fetchRelation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('详情')),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  MeidaCard(
                    id: data!.id!,
                    imageUrl: data!.images?.large!,
                    nameCn: data!.nameCn!,
                    name: data!.name!,
                    genre: data!.metaTags?.join('/'),
                    episode: data!.eps ?? 0,
                    rating: data!.rating?.score,
                    height: 250,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TabBar(
                          controller: tabController,
                          tabs: const [
                            Tab(text: '简介'),
                            Tab(text: '人物'),
                            Tab(text: '角色'),
                            Tab(text: '关联作品'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              SingleChildScrollView(
                                child: Text(data?.summary ?? '暂无简介'),
                              ),
                              person != null
                                  ? ListView.builder(
                                      itemCount: person?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        final p = person![index];
                                        return ListTile(
                                          leading: p.images != null
                                              ? Image.network(
                                                  p.images!.medium!,
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.fill,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) => const Icon(
                                                        size: 70,
                                                        Icons.error,
                                                      ),
                                                )
                                              : const Icon(Icons.person),
                                          title: Text(p.name ?? '未知'),
                                          subtitle: Text(p.relation ?? ''),
                                        );
                                      },
                                    )
                                  : const Center(child: Text('人物暂无数据')),
                              character != null
                                  ? ListView.builder(
                                      itemCount: character?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        final c = character![index];
                                        return ListTile(
                                          leading: c.images != null
                                              ? Image.network(
                                                  fit: BoxFit.fill,

                                                  c.images!.medium!,
                                                  // color: Colors.limeAccent,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) => const Icon(
                                                        size: 70,
                                                        Icons.error,
                                                      ),
                                                )
                                              : const Icon(Icons.person),
                                          title: Text(c.name ?? '未知'),
                                          subtitle: Text(c.relation ?? ''),
                                        );
                                      },
                                    )
                                  : const Center(child: Text('角色暂无数据')),
                              relation != null
                                  ? ListView.builder(
                                      itemCount: relation?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        final r = relation![index];
                                        return ListTile(
                                          leading: r.images != null
                                              ? Image.network(
                                                  r.images!.medium!,
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) => const Icon(
                                                        size: 70,
                                                        Icons.error,
                                                      ),
                                                )
                                              : const Icon(Icons.person),
                                          title: Text(r.nameCn ?? '未知'),
                                          subtitle: Text(r.relation ?? ''),
                                        );
                                      },
                                    )
                                  : const Center(child: Text('关联作品暂无数据')),
                            ],
                          ),
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
