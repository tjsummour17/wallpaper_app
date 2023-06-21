import 'package:app/src/common/models/src.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  Photo({
    required this.id,
    this.width = 0,
    this.height = 0,
    this.url = '',
    this.photographer = '',
    this.photographerUrl = '',
    this.photographerId = 0,
    this.avgColor = '',
    this.src = const Src(),
    this.liked = false,
    this.alt = '',
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  static const String idDbColumn = 'id';
  static const String widthDbColumn = 'width';
  static const String heightDbColumn = 'height';
  static const String urlDbColumn = 'url';
  static const String photographerDbColumn = 'photographer';
  static const String photographerUrlDbColumn = 'photographer_url';
  static const String photographerIdDbColumn = 'photographer_id';
  static const String avgColorDbColumn = 'avg_color';
  static const String srcDbColumn = 'src';
  static const String likedDbColumn = 'liked';
  static const String altDbColumn = 'alt';

  final int id;
  final int width;
  final int height;
  final String url;
  final String photographer;
  @JsonKey(name: 'photographer_url')
  final String photographerUrl;
  @JsonKey(name: 'photographer_id')
  final int photographerId;
  @JsonKey(name: 'avg_color')
  final String avgColor;
  final Src src;
  final bool liked;
  final String alt;

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
