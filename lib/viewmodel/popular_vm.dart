import 'package:flutter/cupertino.dart';

import '../models/apiManger.dart';
import '../models/popular.dart';

class PopularModelView with ChangeNotifier {
  List<Results> results = [];
  bool isloading = false;
  String? errorMessage;

  Future<void> getpopular() async {
    isloading = true;
    notifyListeners();
    try {
      final response = await API().getPopular();
      if (response.data!.isNotEmpty) {
        results = response.data ?? [];
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