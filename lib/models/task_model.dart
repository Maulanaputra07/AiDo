import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final List<SubTask> subTasks;
  final bool isDone;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.subTasks = const [],
    required this.isDone,
    required this.createdAt,
  });

  factory Task.fromDoc(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      title: data['title'] ?? '',
      subTasks: (data['subTasks'] as List<dynamic>? ?? [])
        .map((e) => SubTask.fromMap(e as Map<String, dynamic>))
        .toList(),
      isDone: data['isDone'] ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}


class SubTask {
  final String title;
  bool isDone;

  SubTask({
    required this.title,
    this.isDone = false,
  });


  factory SubTask.fromMap(Map<String, dynamic> data) {
    return SubTask(
      title: data['title'] ?? '',
      isDone: data['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return{
      'title': title,
      'isDone': isDone,
    };
  }
}