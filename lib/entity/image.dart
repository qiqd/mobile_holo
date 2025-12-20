import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

/// 图片信息数据类，包含不同尺寸的图片URL
@JsonSerializable()
class Image {
  /// 小尺寸图片URL
  final String? small;

  /// 网格尺寸图片URL
  final String? grid;

  /// 大尺寸图片URL
  final String? large;

  /// 中等尺寸图片URL
  final String? medium;

  const Image({this.small, this.grid, this.large, this.medium});

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
