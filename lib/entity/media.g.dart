// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
  id: json['id'] as String?,
  title: json['title'] as String?,
  titleCn: json['title_cn'] as String?,
  coverUrl: json['coverUrl'] as String?,
);

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'title_cn': instance.titleCn,
  'coverUrl': instance.coverUrl,
};

Line _$LineFromJson(Map<String, dynamic> json) => Line(
  name: json['name'] as String?,
  episodes: (json['episodes'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$LineToJson(Line instance) => <String, dynamic>{
  'name': instance.name,
  'episodes': instance.episodes,
};

Detail _$DetailFromJson(Map<String, dynamic> json) => Detail(
  media: json['media'] == null
      ? null
      : Media.fromJson(json['media'] as Map<String, dynamic>),
  sources: (json['sources'] as List<dynamic>?)
      ?.map((e) => Line.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
  'media': instance.media,
  'sources': instance.sources,
};

MediaWithScore _$MediaWithScoreFromJson(Map<String, dynamic> json) =>
    MediaWithScore(
      media: json['media'] == null
          ? null
          : Media.fromJson(json['media'] as Map<String, dynamic>),
      score: (json['score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MediaWithScoreToJson(MediaWithScore instance) =>
    <String, dynamic>{'media': instance.media, 'score': instance.score};
