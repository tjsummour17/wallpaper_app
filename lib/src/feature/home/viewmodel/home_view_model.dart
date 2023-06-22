import 'package:app/src/common/api/client.dart';
import 'package:app/src/common/models/photo.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel with ChangeNotifier {
  final ApiClient _client = ApiClient();
  List<Photo> _trending = [];

  Photo _anime = Photo(id: -1);
  Photo _nature = Photo(id: -1);
  Photo _cars = Photo(id: -1);
  Photo _animals = Photo(id: -1);

  List<Photo> get trending => _trending;

  Photo get anime => _anime;

  Photo get nature => _nature;

  Photo get cars => _cars;

  Photo get animals => _animals;

  Future<void> fetchHomeData() async {
    final trendingRes = await _client.trending(page: 1, pageSize: 5);
    _trending = trendingRes.photos;
    final animeRes = await _client.searchImages(
      searchQuery: 'Anime',
      page: 1,
      pageSize: 1,
    );
    if (animeRes.photos.isNotEmpty) {
      _anime = animeRes.photos.first;
    }
    final natureRes = await _client.searchImages(
      searchQuery: 'Nature',
      page: 1,
      pageSize: 1,
    );
    if (natureRes.photos.isNotEmpty) {
      _nature = natureRes.photos.first;
    }
    final carsRes = await _client.searchImages(
      searchQuery: 'Cars',
      page: 1,
      pageSize: 1,
    );
    if (carsRes.photos.isNotEmpty) {
      _cars = carsRes.photos.first;
    }
    final animalsRes = await _client.searchImages(
      searchQuery: 'Animals',
      page: 1,
      pageSize: 1,
    );
    if (animalsRes.photos.isNotEmpty) {
      _animals = animalsRes.photos.first;
    }
    notifyListeners();
  }
}
