import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String desc;
  final List<SubTask> subTasks;
  final bool isDone;
  final DateTime? deadline;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.desc,
    this.subTasks = const [],
    required this.isDone,
    this.deadline,
    required this.createdAt,
  });

  double get progres {
    if (subTasks.isEmpty) return 0.0;
    final doneCount = subTasks.where((s) => s.isDone).length;
    return doneCount / subTasks.length;
  }

  Duration? get timeLeft {
    if (deadline == null) return null;
    return deadline!.difference(DateTime.now());
  }

  // bool get isOverdue {
  //   if (deadline == null) return false;
  //   return DateTime.now().isAfter(deadline!) && !isDone;
  // }

  bool get isFailed {
    if (deadline == null) return false;
    return !isDone && DateTime.now().isAfter(deadline!);
  }

  factory Task.fromDoc(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      title: data['title'] ?? '',
      desc: data['desc'] ?? '',
      subTasks: (data['subTasks'] as List<dynamic>? ?? [])
        .map((e) => SubTask.fromMap(e as Map<String, dynamic>))
        .toList(),
      isDone: data['isDone'] ?? false,
      deadline: data['deadline'] != null ? (data['deadline'] as Timestamp).toDate() : null,
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