import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/repository/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  final HomeRepository _myRepo = HomeRepository();

// apiresponse er getter method create korlam
  ApiResponse<List<MovieListModel>> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<List<MovieListModel>> response) {
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchMovieListApi() async {
    setMoviesList(ApiResponse.loading());

    _myRepo.fetchMoviesList().then((value) {
      setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));

      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
