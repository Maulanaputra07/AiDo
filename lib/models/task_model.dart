import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String title;
  final bool isDone;
  final DateTime createdAt;

  Task({
    required this.title,
    required this.isDone,
    required this.createdAt,
  });

  factory Task.fromDoc(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    return Task(
      title: data['title'] ?? '',
      isDone: data['isDone'] ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}