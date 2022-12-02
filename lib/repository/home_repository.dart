import 'package:mvvm/model/movies_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../res/app_urls.dart';

class HomeRepository {
  Future<List<MovieListModel>> fetchMoviesList() async {
    final BaseApiServices _apiServices = NetworkApiService();

    List<MovieListModel> moviesList = [];
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);

      for (Map<String, dynamic> i in response) {
        moviesList.add(MovieListModel.fromJson(i));
      }
      return moviesList;
    } catch (e) {
      throw e;
    }
  }
}
