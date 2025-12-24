import 'package:json_annotation/json_annotation.dart';

part 'history.g.dart';

@JsonSerializable(explicitToJson: true)
class History {
  final String id;
  final String title;
  final DateTime? lastViewAt;
  final int position;
  final String imgUrl;
  final bool isLove;

  History({
    required this.id,
    required this.title,
    this.lastViewAt,
    this.position = 0,
    this.isLove = false,
    required this.imgUrl,
  });

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryToJson(this);
}
