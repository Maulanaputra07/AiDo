// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../repositories/task_repositories.dart';
import 'dart:developer';
// import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

class TaskFilter extends Equatable {
  final bool isTodayOnly;
  final bool? isDone;

  const TaskFilter({this.isTodayOnly = false, this.isDone});

  @override
  List<Object?> get props => [isTodayOnly, isDone];
}


final taskRepositoryProvider = Provider((ref) => TaskRepository());

final taskStreamProvider = StreamProvider.family<List<Task>, TaskFilter>((ref, filter){
  final repo = ref.watch(taskRepositoryProvider);
  final stream = filter.isTodayOnly ? repo.getTodayTask() : repo.getAllTask();

  log("filter isDone ${filter.isDone}");
  print("filter isDone ${filter.isDone}");

  return filter.isDone == null
    ? stream
    : stream.map((tasks) {
        final filtered = tasks.where((t) => t.isDone == filter.isDone).toList();
        log("Filter applied. isDone=${filter.isDone}, count=${filtered.length}");
        return filtered;
      });
});