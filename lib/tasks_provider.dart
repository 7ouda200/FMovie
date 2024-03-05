import 'package:flutter/material.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> tasks = [];
 //DateTime selected=DateTime.now();

  Future<void> getTasks() async {
    tasks = await FirebaseUtils.getAllTasksFromFirestore();
    notifyListeners();
  }
}
