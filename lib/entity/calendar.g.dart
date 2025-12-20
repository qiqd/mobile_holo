// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
  total: (json['total'] as num?)?.toInt(),
  score: (json['score'] as num?)?.toDouble(),
);

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
  'total': instance.total,
  'score': instance.score,
};

Calendar _$CalendarFromJson(Map<String, dynamic> json) => Calendar(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CalendarToJson(Calendar instance) => <String, dynamic>{
  'items': instance.items,
};

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  type: (json['type'] as num?)?.toInt(),
  name: json['name'] as String?,
  nameCn: json['name_cn'] as String?,
  summary: json['summary'] as String?,
  airDate: json['air_date'] as String?,
  airWeekday: (json['air_weekday'] as num?)?.toInt(),
  rating: json['rating'] == null
      ? null
      : Rating.fromJson(json['rating'] as Map<String, dynamic>),
  rank: (json['rank'] as num?)?.toInt(),
  images: json['images'] == null
      ? null
      : Image.fromJson(json['images'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'type': instance.type,
  'name': instance.name,
  'name_cn': instance.nameCn,
  'summary': instance.summary,
  'air_date': instance.airDate,
  'air_weekday': instance.airWeekday,
  'rating': instance.rating,
  'rank': instance.rank,
  'images': instance.images,
};
