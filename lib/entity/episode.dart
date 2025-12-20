import 'package:json_annotation/json_annotation.dart';
part 'episode.g.dart';

/// 剧集信息实体类
@JsonSerializable()
class Data {
  /// 放送日期
  @JsonKey(name: 'air_date')
  final String? airDate;

  /// 剧集名称
  final String? name;

  /// 剧集中文名称
  @JsonKey(name: 'name_cn')
  final String? nameCn;

  /// 时长
  final String? duration;

  /// 简介
  final String? desc;

  /// 剧集内的集数，从1开始
  final int? ep;

  /// 同类条目的排序和集数
  final double? sort;

  /// 章节ID
  final int? id;

  /// 条目ID
  @JsonKey(name: 'subject_id')
  final int? subjectId;

  /// 回复数量
  final int? comment;

  /// 章节类型
  final int? type;

  /// 音乐曲目的碟片数
  final int? disc;

  /// 服务器解析的时长，单位秒
  @JsonKey(name: 'duration_seconds')
  final int? durationSeconds;

  Data({
    this.airDate,
    this.name,
    this.nameCn,
    this.duration,
    this.desc,
    this.ep,
    this.sort,
    this.id,
    this.subjectId,
    this.comment,
    this.type,
    this.disc,
    this.durationSeconds,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

/// 剧集搜索结果实体类
@JsonSerializable()
class Episode {
  /// 剧集列表
  final List<Data>? data;

  /// 总剧集数
  final int? total;

  /// 每页剧集数
  final int? limit;

  /// 偏移量
  final int? offset;

  Episode({this.data, this.total, this.limit, this.offset});

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}
