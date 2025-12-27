import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable()
class Media {
  String? id;
  String? title;
  String? type;
  String? coverUrl;
  double? score;

  Media({this.id, this.title, this.type, this.coverUrl, this.score = 0});

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
  List<Line>? lines;

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);

  Map<String, dynamic> toJson() => _$DetailToJson(this);

  Detail({this.media, this.lines});
}
