import 'package:aido/models/task_model.dart';
import 'package:aido/pages/detail_task.dart';
import 'package:aido/repositories/task_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:developer';

class ListTaskPage extends ConsumerWidget {
  const ListTaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyListTaskPage();
  }
}

class MyListTaskPage extends ConsumerStatefulWidget {
  const MyListTaskPage({super.key});

  @override
  ConsumerState<MyListTaskPage> createState() => _MyListPageState();
}

class _MyListPageState extends ConsumerState<MyListTaskPage> {

  // void _deleteTask(Task task, int index) async {
  //   log("delete di klik");
  //   await taskRepository.deleteTask(task.id);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 50, top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "List Task",
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Instrument',
                fontWeight: FontWeight.bold,
                color: Color(0xFF1483C2)
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Consumer(
                    builder: (context, ref, _) {
                      final taskStream = ref.watch(taskStreamProvider(const TaskFilter(isTodayOnly: false, isDone: null)));

                      return taskStream.when(
                        data: (tasks){
                          if(tasks.isEmpty){
                            return Center(
                              child: Text(
                                "Anda belum memilik task untuk hari ini",
                                style: TextStyle(
                                  fontFamily: "Instrument",
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: tasks.length,
                            itemBuilder: (context, index){
                              final task = tasks[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (_) => TaskDetailPage(task: task)),
                                    );
                                },
                                child: Slidable(
                                  key: ValueKey(task.id),
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(), 
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          ref.read(taskRepositoryProvider).deleteTask(task.id);
                                          log("Slidable action ditekan");
                                        },
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                        )
                                    ]
                                  ),
                                  child: Container(
                                height: 120,
                                margin: EdgeInsets.only(bottom:12),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  border: Border.all(color: Colors.black),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFC2C6CE),
                                      spreadRadius: 2,
                                      offset: Offset(2, 2)
                                    )
                                  ],
                                color: task.isFailed ? Color(0x80E43636) : (task.isDone ? Color(0xFF93DA97) : Color(0xFFEEEEEE)),
                                ),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                        children: [
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: task.isFailed ? Color(0xFFE43636) : (task.isDone ? Color(0xFF78C841) : Color(0xFFEEEEEE)),
                                                borderRadius: BorderRadius.circular(9),
                                                border: Border.all(
                                                  color: Color(0xFF333333),
                                                  width: 2,
                                                )
                                              ),
                                              child: Image.asset(
                                                task.isFailed ? 'assets/icons/failed.png' : (task.isDone ? 'assets/icons/success.png' : 'assets/icons/progress.png'),
                                              width: 25,
                                              height: 25,
                                              color: Color(0xFF333333),
                                            ),
                                          ),
                                          SizedBox(width: 8,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                task.title,
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF333333)
                                                ),
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                "${task.subTasks.length} subtask",
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0xFF333333)
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                ),
                              ),
                                )
                              );
                            }
                          );
                        }, 
                        error: (e, _) => Text('error: $e'), 
                        loading: () => Center(child: Text("Loading.."))
                      );
                    }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}