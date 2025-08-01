import 'package:flutter/material.dart';
import '../models/task_model.dart';


class TaskDetailPage extends StatelessWidget {
  final Task task;

  const TaskDetailPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(
                fontFamily: 'Instrument',
                fontSize: 45, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF1483C2),
              ),),
            SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: task.subTasks.length,
                itemBuilder: (context, index) {
                  final subtask = task.subTasks[index];
                  return Card(
                    child: ListTile(
                      tileColor: Color(0xFFFAFAFA),
                      leading: Icon(Icons.check_box_outline_blank),
                      title: Text(subtask.title),
                    ),
                  );
                },
              ),
            )
          ],
        )
        
      )
    );
  }

}