import 'package:flutter/material.dart';
import 'package:aido/providers/task_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

class TaskDetailPage extends StatefulWidget{
  final Task task;

  const TaskDetailPage({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    final timeLeft = widget.task.timeLeft;
    log("timeleft: ${widget.task.timeLeft}");
    log("isFailed: ${widget.task.isFailed}");

    String formatTimeLeft(Duration? timeLeft){
      if(timeLeft == null){
        return "Tidak ada deadline";
      } else if(timeLeft.isNegative) {
        if (timeLeft.abs().inHours > 24){
          return "Terlambat ${timeLeft.abs().inDays} hari";
        }
        return "Terlambat ${timeLeft.abs().inHours} jam";
      } else if(timeLeft.inDays > 0) {
        return "${timeLeft.inDays} hari lagi";
      } else if(timeLeft.inHours > 0) {
        return "${timeLeft.inHours} jam lagi";
      }else {
        return "${timeLeft.inMinutes} menit lagi";
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA), 
      ),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.title,
                style: TextStyle(
                  fontSize: 40,
                  color: const Color(0xFF1483C2),
                  fontFamily: 'Instrument',
                  fontWeight: FontWeight.w900
                ),
              ), 
              SizedBox(height: 10,),
              Text(
                widget.task.desc,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  color: const Color(0xFF333333),
                  fontFamily: 'Instrument',
                  fontWeight: FontWeight.normal
                ),
              ), 
              SizedBox(height: 10,),
              Text(
                widget.task.deadline != null ?
                  'Deadline : ${DateFormat('dd MMM yyyy, HH:mm').format(widget.task.deadline!)}' : 'Tidak ada deadline',
                style: TextStyle(
                  fontFamily: 'Instrument',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFF1483C2)
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                child: Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: widget.task.isFailed ? Color(0x80E43636) : Color(0xFFE3EBFA),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons/date.png',
                        width: 35,
                      ),
                      SizedBox(width: 2,),
                      Text(
                        widget.task.isFailed ? 
                        "Failed, ${formatTimeLeft(timeLeft)}" :
                        (widget.task.isDone ? "Done" : formatTimeLeft(timeLeft)),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color(0xFF333333),
                          fontFamily: 'Instrument',
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  )
                ), 
              ),
            ],
          )

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
                        },
                        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if(states.contains(WidgetState.selected)) {
                            return Color(0xFF1483C2);
                          }

                          return Color(0xFFFAFAFA);
                        }),
                        checkColor: Color(0xFFFAFAFA),
                        side: const BorderSide(
                          color: Color(0xFF1483C2),
                          width: 1.4
                        ),
                        ),
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