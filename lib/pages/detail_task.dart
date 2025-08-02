import 'package:flutter/material.dart';
import 'package:aido/providers/task_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';


class TaskDetailPage extends StatefulWidget{
  final Task task;

  const TaskDetailPage({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(),
      body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(17),
          child: Text(
            widget.task.title,
            style: TextStyle(
              fontSize: 40,
              color: const Color(0xFF1483C2),
              fontFamily: 'Instrument',
              fontWeight: FontWeight.bold
            ),
          ), 
        ),

        Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final taskRepo = ref.read(taskRepositoryProvider);
              
                return ListView.builder(
                itemCount: widget.task.subTasks.length,
                itemBuilder: (context, index) {
                  final subtask = widget.task.subTasks[index];

                  return Card(
                    child: ListTile(
                      tileColor: const Color(0xFFFAFAFA),
                      leading: Checkbox(
                        value: subtask.isDone,
                        onChanged: (value) async {
                          if (value == null) return;

                          setState(() {
                            subtask.isDone = value;
                          });

                          await taskRepo.updateSubTasks(widget.task.id, widget.task.subTasks);
                        }),
                        title: Text(subtask.title, style: TextStyle(
                          color: const Color(0xFF333333),
                          fontFamily: 'Instrument',
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),),
                    ),
                  );
                },
              );
              },
            )
            
            ),
      ]
    ),
    );
  }
}