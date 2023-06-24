import 'package:app/src/common/database/sqflite_database.dart';
import 'package:app/src/common/models/photo.dart';
import 'package:flutter/cupertino.dart';

class FavoritesViewModel with ChangeNotifier {
  List<Photo> _photos = [];
  bool _isLoading = true;
  bool _noMoreItems = false;
  bool _isLoadingNextPage = false;
  int _pageIndex = 1;

  bool get isLoading => _isLoading;

  List<Photo> get photos => _photos;

  bool get noMoreItems => _noMoreItems;

  bool get isLoadingNextPage => _isLoadingNextPage;

  Future<void> fetchFavorites() async {
    _isLoading = true;
    _pageIndex = 0;
    _noMoreItems = false;
    _photos = await SqfliteDatabase.queryFavorites(
      index: _pageIndex,
      limit: 10,
    );
    _pageIndex++;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getMore({required String search}) async {
    _isLoadingNextPage = true;
    notifyListeners();
    final photos = await SqfliteDatabase.queryFavorites(
      index: _pageIndex,
      limit: 10,
    );
    _pageIndex++;
    if (photos.length < 10) {
      _noMoreItems = true;
    } else {
      _photos.addAll(photos);
    }
    _isLoadingNextPage = false;
    notifyListeners();
  }

  Future<void> addToFavorite({required Photo photo}) async {
    _photos.add(photo);
    notifyListeners();
    await SqfliteDatabase.addFavPhoto(photo);
  }

  Future<void> removeFromFav({required Photo photo}) async {
    _photos.remove(photo);
    notifyListeners();
    await SqfliteDatabase.deleteFavPhoto(photo.id);
  }

  bool isInFavorite({required Photo photo}) =>
      _photos.indexWhere((element) => element.id == photo.id) != -1;
}
