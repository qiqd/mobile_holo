// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  airDate: json['air_date'] as String?,
  name: json['name'] as String?,
  nameCn: json['name_cn'] as String?,
  duration: json['duration'] as String?,
  desc: json['desc'] as String?,
  ep: (json['ep'] as num?)?.toInt(),
  sort: (json['sort'] as num?)?.toDouble(),
  id: (json['id'] as num?)?.toInt(),
  subjectId: (json['subject_id'] as num?)?.toInt(),
  comment: (json['comment'] as num?)?.toInt(),
  type: (json['type'] as num?)?.toInt(),
  disc: (json['disc'] as num?)?.toInt(),
  durationSeconds: (json['duration_seconds'] as num?)?.toInt(),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'air_date': instance.airDate,
  'name': instance.name,
  'name_cn': instance.nameCn,
  'duration': instance.duration,
  'desc': instance.desc,
  'ep': instance.ep,
  'sort': instance.sort,
  'id': instance.id,
  'subject_id': instance.subjectId,
  'comment': instance.comment,
  'type': instance.type,
  'disc': instance.disc,
  'duration_seconds': instance.durationSeconds,
};

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  offset: (json['offset'] as num?)?.toInt(),
);

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
  'data': instance.data,
  'total': instance.total,
  'limit': instance.limit,
  'offset': instance.offset,
};
