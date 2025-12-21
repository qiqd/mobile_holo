import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable()
class Media {
  String? id;
  String? title;
  @JsonKey(name: 'title_cn')
  String? titleCn;
  String? coverUrl;
  Media({this.id, this.title, this.titleCn, this.coverUrl});
  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
  Map<String, dynamic> toJson() => _$MediaToJson(this);
}

@JsonSerializable()
class Line {
  String? name;
  List<String>? episodes;
  Line({this.name, this.episodes});
  factory Line.fromJson(Map<String, dynamic> json) => _$LineFromJson(json);
  Map<String, dynamic> toJson() => _$LineToJson(this);
}

@JsonSerializable()
class Detail {
  Media? media;
  List<Line>? sources;
  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);
  Map<String, dynamic> toJson() => _$DetailToJson(this);
  Detail({this.media, this.sources});
}

@JsonSerializable()
class MediaWithScore {
  Media? media;
  double? score;
  MediaWithScore({this.media, this.score});
  factory MediaWithScore.fromJson(Map<String, dynamic> json) =>
      _$MediaWithScoreFromJson(json);
  Map<String, dynamic> toJson() => _$MediaWithScoreToJson(this);
}
