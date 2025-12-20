// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectRelation _$SubjectRelationFromJson(Map<String, dynamic> json) =>
    SubjectRelation(
      images: json['images'] == null
          ? null
          : Image.fromJson(json['images'] as Map<String, dynamic>),
      name: json['name'] as String?,
      nameCn: json['name_cn'] as String?,
      relation: json['relation'] as String?,
      type: (json['type'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubjectRelationToJson(SubjectRelation instance) =>
    <String, dynamic>{
      'images': instance.images,
      'name': instance.name,
      'name_cn': instance.nameCn,
      'relation': instance.relation,
      'type': instance.type,
      'id': instance.id,
    };
