import 'package:app/src/common/api/client.dart';
import 'package:app/src/common/models/pagination_response.dart';
import 'package:app/src/common/models/photo.dart';
import 'package:flutter/cupertino.dart';

class SearchViewModel with ChangeNotifier {
  final ApiClient _client = ApiClient();
  List<Photo> _photos = [];
  bool _isLoading = true;
  bool _noMoreItems = false;
  bool _isLoadingNextPage = false;
  int _pageIndex = 1;

  bool get isLoading => _isLoading;

  List<Photo> get photos => _photos;

  bool get noMoreItems => _noMoreItems;

  bool get isLoadingNextPage => _isLoadingNextPage;

  Future<void> search({required String search}) async {
    _isLoading = true;
    _pageIndex = 0;
    _noMoreItems = false;
    final PaginationResponse<Photo> res;
    if (search.isNotEmpty) {
      res = await _client.searchImages(
        searchQuery: search,
        page: _pageIndex,
        pageSize: 10,
      );
    } else {
      res = await _client.trending(
        page: _pageIndex,
        pageSize: 10,
      );
    }
    _pageIndex++;
    _photos = res.photos;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getMore({required String search}) async {
    _isLoadingNextPage = true;
    notifyListeners();
    final PaginationResponse<Photo> res;
    if (search.isNotEmpty) {
      res = await _client.searchImages(
        searchQuery: search,
        page: _pageIndex,
        pageSize: 10,
      );
    } else {
      res = await _client.trending(
        page: _pageIndex,
        pageSize: 10,
      );
    }
    _pageIndex++;
    if (res.photos.length < 10){
      _noMoreItems = true;
    } else {
      _photos.addAll(res.photos);
    }
    _isLoadingNextPage = false;
    notifyListeners();
  }
}
