import 'package:flutter/cupertino.dart';

import '../models/apiManger.dart';
import 'package:movies_app/models/search.dart';
class SearchModelView with ChangeNotifier {
  List<Results> results = [];
  bool isloading = false;
  String? errorMessage;

  Future<void> getsearch(String query) async {
    isloading = true;
    notifyListeners();
    try {
      final response = await API().getsearchmovie(query);
      if (response.results!.isNotEmpty) {
        results.clear();
        results = response.results ?? [];
      } else {
        errorMessage = 'failed to get results';
      }
    } catch (error) {
      errorMessage = error.toString();
    }
    isloading = false;
    notifyListeners();
  }

  void clear(){
    results.clear();
    notifyListeners();

}
}