import 'package:json_annotation/json_annotation.dart';

part 'history.g.dart';

@JsonSerializable(explicitToJson: true)
class History {
  final int id;
  final String title;
  DateTime? lastViewAt = DateTime(1980);
  int position;
  String imgUrl;
  bool isLove;
  int episodeIndex;
  int lineIndex;
  History({
    required this.id,
    required this.title,
    this.lastViewAt,
    this.position = 0,
    this.isLove = false,
    required this.imgUrl,
    this.episodeIndex = 0,
    this.lineIndex = 0,
  });

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryToJson(this);
}
