import 'package:flutter/cupertino.dart';
import '../models/apiManger.dart';
import '../models/movieList.dart';
class MovieListModelView with ChangeNotifier {
  List<Genres> genres = [];
  bool isloading = false;
  String? errorMessage;

  Future<void> getMovieList() async {
    isloading = true;
    notifyListeners();
    try {
      final response = await API().getMovieList();
      if (response.genres!.isNotEmpty) {
        genres = response.genres ?? [];
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