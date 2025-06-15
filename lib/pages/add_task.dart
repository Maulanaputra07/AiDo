import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget{
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _taskController = TextEditingController();

  Future<void> _saveTask() async{
      final taskText = _taskController.text;

      if(taskText.isNotEmpty){
        await FirebaseFirestore.instance.collection('tasks').add({
          'title': taskText,
          'createdAt': FieldValue.serverTimestamp(),
          'isDone': false,
        });
        
        if(!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task berhasil disimpan'))
        );

        Navigator.pop(context);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Isi task tidak bisa kosong')),
        );
      }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AiDo - Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: "Task",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: const Text("Save"),
              )
          ],
        ),
        ),
    );
  }

}