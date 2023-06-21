// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationResponse<T> _$PaginationResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginationResponse<T>(
      page: json['page'] as int,
      perPage: json['per_page'] as int,
      photos: (json['photos'] as List<dynamic>).map(fromJsonT).toList(),
      totalResults: json['total_results'] as int,
      nextPage: json['next_page'] as String?,
    );

Map<String, dynamic> _$PaginationResponseToJson<T>(
  PaginationResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'page': instance.page,
      'per_page': instance.perPage,
      'photos': instance.photos.map(toJsonT).toList(),
      'total_results': instance.totalResults,
      'next_page': instance.nextPage,
    };
