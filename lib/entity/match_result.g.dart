// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchResult _$MatchResultFromJson(Map<String, dynamic> json) => MatchResult(
  media: Media.fromJson(json['media'] as Map<String, dynamic>),
  score: (json['score'] as num).toDouble(),
);

Map<String, dynamic> _$MatchResultToJson(MatchResult instance) =>
    <String, dynamic>{'media': instance.media, 'score': instance.score};
