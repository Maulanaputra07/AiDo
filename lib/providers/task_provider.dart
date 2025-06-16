// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../repositories/task_repositories.dart';

// final taskStreamProvider = StreamProvider<List<Task>>((ref) {
//   return FirebaseFirestore.instance
//     .collection('task')
//     .orderBy('createdAt', descending: true)
//     .snapshots()
//     .map((snapshot) => snapshot.docs.map((doc) => Task.fromDoc(doc)).toList());
// });

final taskRepositoryProvider = Provider((ref) => TaskRepository());

final taskStreamProvider = StreamProvider.family<List<Task>, bool>((ref, isTodayOnly){
  final repo = ref.watch(taskRepositoryProvider);
  return isTodayOnly ? repo.getTodayTask() : repo.getAllTask();
});