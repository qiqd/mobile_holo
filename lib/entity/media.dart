import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable()
class Media {
  String? id;
  String? title;
  @JsonKey(name: 'title_cn')
  String? titleCn;
  @JsonKey(name: 'title_en')
  String? titleEn;
  String? author;
  @JsonKey(name: 'cover_urls')
  List<String>? coverUrls;
  String? description;
  String? genre;
  String? status;
  String? rating;
  @JsonKey(name: 'rating_info')
  RatingInfo? ratingInfo;
  @JsonKey(name: 'rating_count')
  String? ratingCount;
  String? views;
  @JsonKey(name: 'source_site')
  String? sourceSite;
  @JsonKey(name: 'source_url')
  String? sourceUrl;
  String? platform;
  @JsonKey(name: 'release_date')
  String? releaseDate;

  Media({
    this.id,
    this.title,
    this.titleCn,
    this.titleEn,
    this.author,
    this.coverUrls,
    this.description,
    this.genre,
    this.status,
    this.rating,
    this.ratingInfo,
    this.ratingCount,
    this.views,
    this.sourceSite,
    this.sourceUrl,
    this.platform,
    this.releaseDate,
  });

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
  Map<String, dynamic> toJson() => _$MediaToJson(this);
}

@JsonSerializable()
class RatingInfo {
  // Add fields based on your RatingInfo structure
  // This is a placeholder - you'll need to define the actual fields

  RatingInfo();

  factory RatingInfo.fromJson(Map<String, dynamic> json) =>
      _$RatingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RatingInfoToJson(this);
}
