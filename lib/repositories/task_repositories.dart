import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/task_model.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../main.dart';

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
      'desc' : task.desc,
      'isDone' : task.isDone,
      'deadline' : task.deadline != null ? Timestamp.fromDate(task.deadline!) : null,
      'subTasks' : task.subTasks.map((sub) => sub.toMap()).toList(),
      'createdAt' : Timestamp.fromDate(task.createdAt),
    });

    if(task.deadline != null){
      await scheduleTaskReminder(task.deadline!, task.title);
    }
  }

  Future<void> updateSubTasks(String taskId, List<SubTask> subTasks) async {
    final allDone = subTasks.every((s) => s.isDone);
    
    await _db.collection('tasks').doc(taskId).update({
      'subTasks': subTasks.map((s) => s.toMap()).toList(),
      'isDone' : allDone
    });
  }
}

  Future<void> scheduleTaskReminder(DateTime deadline, String taskName) async {

    final scheduledTime = deadline.subtract(Duration(days: 1));

    // const AndroidNotificationDetails androidPlatformChannelSpecifics = 
    //   AndroidNotificationDetails(
    //     'task_channel',
    //     'task_reminder',
    //     channelDescription: 'Notifikasi pengingat task',
    //     importance: Importance.high,
    //     priority: Priority.high
    //   );

      // const NotificationDetails platformChannelSpecifics = 
      //   NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Pengingat Task',
        'Task "$taskName" harus selesai besok!',
        tz.TZDateTime.from(scheduledTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'task_channel', 
            'Task Reminder',
            importance: Importance.high,
            priority: Priority.high
          )
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
  }