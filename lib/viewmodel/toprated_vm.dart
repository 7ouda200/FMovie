import 'package:flutter/cupertino.dart';

import '../models/apiManger.dart';
import 'package:movies_app/models/toprated.dart';
class TopratedModelView with ChangeNotifier {
  List<Results> results = [];
  bool isloading = false;
  String? errorMessage;

  Future<void> gettoprated() async {
    isloading = true;
    notifyListeners();
    try {
      final response = await API().getToprated();
      if (response.results!.isNotEmpty) {
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
}