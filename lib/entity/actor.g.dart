// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Actor _$ActorFromJson(Map<String, dynamic> json) => Actor(
  images: json['images'] == null
      ? null
      : Image.fromJson(json['images'] as Map<String, dynamic>),
  name: json['name'] as String?,
  shortSummary: json['shortSummary'] as String?,
  career: (json['career'] as List<dynamic>?)?.map((e) => e as String).toList(),
  id: (json['id'] as num?)?.toInt(),
  type: (json['type'] as num?)?.toInt(),
  locked: json['locked'] as bool?,
);

Map<String, dynamic> _$ActorToJson(Actor instance) => <String, dynamic>{
  'images': instance.images?.toJson(),
  'name': instance.name,
  'shortSummary': instance.shortSummary,
  'career': instance.career,
  'id': instance.id,
  'type': instance.type,
  'locked': instance.locked,
};
