import 'package:json_annotation/json_annotation.dart';

part 'src.g.dart';

@JsonSerializable()
class Src {
  const Src({
    this.original = '',
    this.large2X = '',
    this.large = '',
    this.medium = '',
    this.small = '',
    this.portrait = '',
    this.landscape = '',
    this.tiny = '',
  });

  factory Src.fromJson(Map<String, dynamic> json) => _$SrcFromJson(json);
  final String original;
  @JsonKey(name: 'large2x')
  final String large2X;
  final String large;
  final String medium;
  final String small;
  final String portrait;
  final String landscape;
  final String tiny;

  Map<String, dynamic> toJson() => _$SrcToJson(this);
}
