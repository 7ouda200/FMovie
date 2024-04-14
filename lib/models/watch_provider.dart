import 'package:flutter/material.dart';
import 'package:movies_app/models/watchlist.dart';
import 'package:movies_app/models/firebaseutil.dart';

class WatchProvider with ChangeNotifier {
  List<WatchListModel> watches = [];

  Future<void> getWatches() async {
    watches = await FirebaseUtils.getAllTasksFromFirestore();
    notifyListeners();
  }
}