import 'package:aido/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';

class AddTaskPage extends ConsumerStatefulWidget{
  const AddTaskPage({super.key});

  @override
  ConsumerState<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final List<SubTask> _subTasks = [];
  final bool _isDone = false;
  bool _isLoading = false;

  void _addSubTask() {
    setState(() {
      _subTasks.add(SubTask(title: ''));
    });
  }

  void _updateSubtasksTitle(int index, String value) {
    setState(() {
      _subTasks[index] = SubTask(
        title: value, 
        isDone: _subTasks[index].isDone,
        );
    });
  }

  void _toggleSubTasksDone(int index, bool? value) {
    setState(() {
      _subTasks[index] = SubTask(title: _subTasks[index].title, isDone: value ?? false);
    });
  }

  Future<void> _saveTask() async{
      final title = _titleController.text.trim();

      if(title.isNotEmpty){
        setState(() {
          _isLoading = true;
        });

        final newTask = Task(
          id: '',
          title: title,
          subTasks: _subTasks,
          isDone: _isDone,
          createdAt: DateTime.now(),
        );


        try{
          final taskRepo = ref.read(taskRepositoryProvider);
          await taskRepo.addTask(newTask);
          
          if(!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task berhasil disimpan'))
          );
          Navigator.pop(context);
        }catch(e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Gagal menambahkan task: $e"))
          );
        }finally {
          setState(() {
            _isLoading = false;
          });
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Isi task tidak bisa kosong')),
        );
      }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        "AiDo - Add Task",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Task title",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
                floatingLabelStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(10)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14)
                // border: OutlineInputBorder(),
              ),
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Sub Task",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),

            ..._subTasks.asMap().entries.map((entry) {
              final index = entry.key;
              final subTask = entry.value;


              return Row(
                children: [
                  Checkbox(
                  value: subTask.isDone, 
                  onChanged: (value) => _toggleSubTasksDone(index, value),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Subtask title",
                      ),
                      onChanged: (value) => _updateSubtasksTitle(index, value),
                    ),
                  ),
                ]
              );
            }).toList(),

            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(onPressed: _addSubTask, icon: const Icon(Icons.add), label: const Text('Tambah Subtask')),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
                onPressed: _isLoading ? null : _saveTask,
                child: _isLoading ? const CircularProgressIndicator() : const Text("Add Task"),
              )
          ],
        ),
        ),
    );
  }

}