// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
  id: json['id'] as String?,
  title: json['title'] as String?,
  titleCn: json['title_cn'] as String?,
  titleEn: json['title_en'] as String?,
  author: json['author'] as String?,
  coverUrls: (json['cover_urls'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  description: json['description'] as String?,
  genre: json['genre'] as String?,
  status: json['status'] as String?,
  rating: json['rating'] as String?,
  ratingInfo: json['rating_info'] == null
      ? null
      : RatingInfo.fromJson(json['rating_info'] as Map<String, dynamic>),
  ratingCount: json['rating_count'] as String?,
  views: json['views'] as String?,
  sourceSite: json['source_site'] as String?,
  sourceUrl: json['source_url'] as String?,
  platform: json['platform'] as String?,
  releaseDate: json['release_date'] as String?,
);

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'title_cn': instance.titleCn,
  'title_en': instance.titleEn,
  'author': instance.author,
  'cover_urls': instance.coverUrls,
  'description': instance.description,
  'genre': instance.genre,
  'status': instance.status,
  'rating': instance.rating,
  'rating_info': instance.ratingInfo,
  'rating_count': instance.ratingCount,
  'views': instance.views,
  'source_site': instance.sourceSite,
  'source_url': instance.sourceUrl,
  'platform': instance.platform,
  'release_date': instance.releaseDate,
};

RatingInfo _$RatingInfoFromJson(Map<String, dynamic> json) => RatingInfo();

Map<String, dynamic> _$RatingInfoToJson(RatingInfo instance) =>
    <String, dynamic>{};
