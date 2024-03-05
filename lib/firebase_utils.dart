import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/task_model.dart';

class FirebaseUtils {
  static CollectionReference<TaskModel> getTaskCollection() =>
      FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
            fromFirestore: (snapshot, _) =>
                TaskModel.fromJson(snapshot.data()!),
            toFirestore: (taskModel, _) => taskModel.toJson(),
          );

  static Future<void> addTaskToFirestore(TaskModel task) {
    final taskscollection = getTaskCollection();
    final doc = taskscollection.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Future<List<TaskModel>> getAllTasksFromFirestore() async {
    final taskcollection = getTaskCollection();
    final querySnapshot = await taskcollection.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static void deleteTaskFromFirestore(String taskid) {}

  static void editTaskToFirestore(String id, bool isDone) {
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(id)
        .update({'isDone': isDone});
  }

  static Future<void> editTaskToFirestore2(TaskModel task, String id) {
    final taskscollection = getTaskCollection();
    final doc = taskscollection.doc(id);
    task.id = id;
    return doc.set(task);
  }
}
