import 'package:json_annotation/json_annotation.dart';

part 'pagination_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationResponse<T> {
  PaginationResponse({
    required this.page,
    required this.perPage,
    required this.photos,
    required this.totalResults,
    this.nextPage,
  });

  factory PaginationResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginationResponseFromJson(json, fromJsonT);

  final int page;
  @JsonKey(name: 'per_page')
  final int perPage;
  final List<T> photos;
  @JsonKey(name: 'total_results')
  final int totalResults;
  @JsonKey(name: 'next_page')
  final String? nextPage;

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PaginationResponseToJson(this, toJsonT);
}
