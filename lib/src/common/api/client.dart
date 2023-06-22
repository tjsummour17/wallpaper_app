import 'package:app/src/common/models/pagination_response.dart';
import 'package:app/src/common/models/photo.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'client.g.dart';

const String baseUrl = 'https://api.pexels.com/v1/';

@RestApi(baseUrl: baseUrl)
abstract class ApiClient {
  factory ApiClient() => _ApiClient(_dio);

  static const String _apiKey = 'lIBF1feupWhgfSaN4BK1P4Tu2jb3PldhRxYxyOiYcngNUAlJgMkXuk77';
  static final Dio _dio = Dio(
    BaseOptions(baseUrl: baseUrl, headers: {'Authorization': _apiKey}),
  );
  static const String _search = 'search';
  static const String _trending = 'curated';



  @GET(_search)
  Future<PaginationResponse<Photo>> searchImages({
    @Query('query') required String searchQuery,
    @Query('page') required int page,
    @Query('per_page') required int pageSize,
  });

  @GET(_trending)
  Future<PaginationResponse<Photo>> trending({
    @Query('page') required int page,
    @Query('per_page') required int pageSize,
  });
}
