import 'package:flutter/cupertino.dart';

import '../models/apiManger.dart';

import '../models/moviedetails.dart';
class MovieDetailsModelView with ChangeNotifier {
  List<Genres> genres = [];
  var title;
  var overview;
  var posterpath;
  var backdrop_path;
  var voteAvg;
  var date;
  bool isloading = false;
  String? errorMessage;

  Future<void> getMovieDetails(int movieId) async {

    isloading = true;
    notifyListeners();
    try {
      final response = await API().getmoviedetails(movieId);
      if (response.genres!.isNotEmpty) {
        genres = response.genres ?? [];
        title =response.title;
        overview=response.overview;
        posterpath=response.posterPath;
        backdrop_path=response.backdropPath;
        voteAvg=response.voteAverage;
        date=response.releaseDate;
        print('qqqqqq$backdrop_path');
      } else {
        errorMessage = 'failed to get results';
      }
    } catch (error) {
      errorMessage = error.toString();
    }
    isloading = false;
    notifyListeners();
  }
}