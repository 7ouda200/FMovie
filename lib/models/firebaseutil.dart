import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/models/watchlist.dart';

class FirebaseUtils {
  static CollectionReference<WatchListModel> getWatchCollection() =>
      FirebaseFirestore.instance.collection('watch').withConverter<WatchListModel>(
        fromFirestore: (snapshot, _) =>
            WatchListModel.fromJson(snapshot.data()!),
        toFirestore: (taskModel, _) => taskModel.toJson(),
      );

  static Future<void> addWatchToFirestore(WatchListModel watch) {
    final watchscollection = getWatchCollection();
    final doc = watchscollection.doc();
    watch.id = doc.id;
    return doc.set(watch);
  }

  static Future<List<WatchListModel>> getAllTasksFromFirestore() async {
    final taskcollection = getWatchCollection();
    final querySnapshot = await taskcollection.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }



  static void editTaskToFirestore(String id, bool isDone) {
    FirebaseFirestore.instance
        .collection('watch')
        .doc(id)
        .update({'isDone': isDone});
  }

  // static Future<void> editTaskToFirestore2(WatchListModel task, String id) {
  //   final taskscollection = getTaskCollection();
  //   final doc = taskscollection.doc(id);
  //   task.id = id;
  //   return doc.set(task);
  // }
  // static Future<void> deleteTaskToFirestore(String id) {
  //   final taskscollection = getTaskCollection();
  //   return taskscollection.doc(id).delete();
  //
  // }

}