import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/task_model.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
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
    final user = FirebaseAuth.instance.currentUser;
    if(user == null ) return;

    await _db.collection('tasks').add({
      'title' : task.title,
      'desc' : task.desc,
      'isDone' : task.isDone,
      'ownerUid' : user.uid,
      'collaborators' : <String>[],
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
  
  Future<void> deleteTask(String taskId) async {
    await _db.collection('tasks').doc(taskId).delete();
  }

  Future<void> scheduleTaskReminder(DateTime deadline, String taskName) async {
    final scheduledTime = deadline.subtract(Duration(days: 1));
    // final scheduledTime = DateTime.now().add(const Duration(seconds: 5));
    print("📅 Notif dijadwalkan untuk: $scheduledTime (${taskName})");
    
    if(scheduledTime.isBefore(DateTime.now())){
      print("⚠️ Waktu notifikasi sudah lewat, tidak dijadwalkan");
      return;
    }

    final granted = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    print("🔔 Permission granted: $granted");

      await flutterLocalNotificationsPlugin.zonedSchedule(
        taskName.hashCode,
        'Pengingat Task',
        'Task $taskName harus selesai besok!',
        tz.TZDateTime.from(scheduledTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'task_channel', 
            'Task Reminder',
            importance: Importance.max,
            priority: Priority.high
          )
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );

      final pending = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
      print("📋 Pending notifikasi: ${pending.map((e) => "${e.id} - ${e.title}").toList()}");
  }

  Future<void> addCollaborators(String taskId, String userId) async {
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
      'collaborators' : FieldValue.arrayUnion([userId])
    });
  }

  Future<void> removeCollaborators(String taskId, String userId) async {
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
      'collaborators' : FieldValue.arrayRemove([userId])
    });
  }

  Future<String?> getUidByUsername(String username) async {
    final snapshot = await FirebaseFirestore.instance
    .collection('users')
    .where('username', isEqualTo: username)
    .limit(1)
    .get();

    if (snapshot.docs.isEmpty) return null;
    return snapshot.docs.first.id;
  }
}
