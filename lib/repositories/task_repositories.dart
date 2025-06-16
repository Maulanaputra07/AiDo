import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class TaskRepository {
  final _db = FirebaseFirestore.instance;

  Stream<List<Task>> getAllTask(){
    return _db.collection('tasks')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Task.fromDoc(doc)).toList());
  }

  Stream<List<Task>> getTodayTask(){
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(Duration(days: 1));
  
    return _db.collection('tasks')
      .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
      .where('createdAt', isLessThan: Timestamp.fromDate(endOfDay))
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Task.fromDoc(doc)).toList());
  }

  Future<void> addTask(Task task) async{
    await _db.collection('tasks').add({
      'title' : task.title,
      'isDone' : task.isDone,
      'createdAt' : Timestamp.fromDate(task.createdAt),
    });
  }
}