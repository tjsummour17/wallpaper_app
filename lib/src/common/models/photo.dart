import 'dart:convert';

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

  factory Photo.fromSqlJson(Map<String, dynamic> json) => Photo(
        id: json['id'] as int,
        width: json['width'] as int? ?? 0,
        height: json['height'] as int? ?? 0,
        url: json['url'] as String? ?? '',
        photographer: json['photographer'] as String? ?? '',
        photographerUrl: json['photographer_url'] as String? ?? '',
        photographerId: json['photographer_id'] as int? ?? 0,
        avgColor: json['avg_color'] as String? ?? '',
        src: json['src'] == null
            ? const Src()
            : Src.fromJson(jsonDecode(json['src'] as String)),
        liked: json['liked'] != 0,
        alt: json['alt'] as String? ?? '',
      );

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

  Map<String, dynamic> toSqlJson() => <String, dynamic>{
        'id': id,
        'width': width,
        'height': height,
        'url': url,
        'photographer': photographer,
        'photographer_url': photographerUrl,
        'photographer_id': photographerId,
        'avg_color': avgColor,
        'src': jsonEncode(src.toJson()),
        'liked': liked ? 1 : 0,
        'alt': alt,
      };
}
