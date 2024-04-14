import 'package:flutter/cupertino.dart';

import '../models/apiManger.dart';
import 'package:movies_app/models/similarMovies.dart';
class SimilarMoviesModelView with ChangeNotifier {
  List<Results> results = [];
  bool isloading = false;
  String? errorMessage;

  Future<void> getSimilarMovies(int MovieId) async {
    isloading = true;
    notifyListeners();
    try {
      final response = await API().getsimilardmovie(MovieId);
      if (response.results!.isNotEmpty) {
        results = response.results ??[];
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