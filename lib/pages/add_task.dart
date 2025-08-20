import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';
import 'package:aido/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AddTaskPage extends ConsumerStatefulWidget{
  const AddTaskPage({super.key});

  @override
  ConsumerState<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<SubTask> _subTasks = [];
  final bool _isDone = false;
  bool _isLoading = false;
  DateTime? selectedDeadline;

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

  void _deleteSubtask(int index){
    setState(() {
      _subTasks.removeAt(index);
    });
  }

  void _toggleSubTasksDone(int index, bool? value) {
    setState(() {
      _subTasks[index] = SubTask(title: _subTasks[index].title, isDone: value ?? false);
    });
  }

  Future<void> _saveTask() async{
      final title = _titleController.text.trim();
      final desc = _descriptionController.text.trim();

      if(title.isNotEmpty && desc.isNotEmpty){
        setState(() {
          _isLoading = true;
        });

        final newTask = Task(
          id: '',
          title: title,
          desc: desc,
          subTasks: _subTasks,
          isDone: _isDone,
          deadline: selectedDeadline,
          createdAt: DateTime.now(),
        );


        try{
          final taskRepo = ref.read(taskRepositoryProvider);
          await taskRepo.addTask(newTask);
          
          if(!mounted) return;
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            title: "Success",
            desc: "Berhasil menambahkan task",
            btnOkOnPress: () {
              Navigator.pop(context);
            },
            btnOkText: "Oke",
            btnOkColor: Color(0xFF1483C2)
        ).show();
          // ScaffoldMessenger.of(context).showSnackBar(
          // const SnackBar(content: Text('Task berhasil disimpan'))
          // );
        }catch(e) {
          log("++ gagal add task : $e");
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            title: "Error",
            desc: "Gagal menambahkan task: $e",
            btnOkOnPress: () {},
            btnOkText: "Oke",
            btnOkColor: Color(0xFF1483C2)
        ).show();
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text("Gagal menambahkan task: $e"))
          // );
        }finally {
          setState(() {
            _isLoading = false;
          });
        }
      }else{
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: "Error",
          desc: "Harap isi task terlebih dahulu",
          btnOkOnPress: () {},
          btnOkText: "Oke",
          btnOkColor: Color(0xFF1483C2)
        ).show();
      }
  }

  Future<void> pickDeadlinewithTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), 
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogThemeData(
              backgroundColor: Color(0xFFFAFAFA),
            ),
            colorScheme: ColorScheme.light(
              primary: Colors.black54,
              onPrimary: Colors.black,
              onSurface: Colors.black
            )
          ), 
          child: child!
        );
      }
    );

    if (date != null){
      final TimeOfDay? time = await showTimePicker(
        context: context, 
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogThemeData(
              backgroundColor: Color(0xFFFAFAFA),
            ),
            colorScheme: ColorScheme.light(
              primary: Colors.black54,
              onPrimary: Colors.black,
              onSurface: Colors.black
            )
          ), 
          child: child!
        );
      }
      );
      
      if (time != null) {
        final combined = DateTime(
          date.year,
          date.month, 
          date.day, 
          time.hour, 
          time.minute
        );

        setState(() {
          selectedDeadline = combined;
        });
      }
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
        "Add Task",
        style: TextStyle(
          fontFamily: "Inknut",
          fontSize: 30,
          letterSpacing: 0,
          color: Color(0xFF1483C2),
          fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: Color(0xFFFAFAFA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF6F6F6),
                labelText: "Title",
                labelStyle: TextStyle(
                  color: Color(0xFF1483C2),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Instrument",
                  fontSize: 50,
                ),
                floatingLabelStyle: TextStyle(
                  fontSize: 25,
                  color: Color(0xFF1483C2),
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF333333), width: 2),
                  borderRadius: BorderRadius.circular(10)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14)
                // border: OutlineInputBorder(),
              ),
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Instrument',
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF6F6F6),
                // labelText: 'Description',
                hintText: 'Deskripsi',
                hintStyle: TextStyle(
                  color: Color(0xFF1483C2),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Instrument",
                  fontSize: 25,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF333333), width: 2),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),

            const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                // Text(
                //   selectedDeadline != null ?
                //   "Deadline" : "",
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontFamily: 'Instrument',
                //     color: Color(0xFF1483C2),
                //     fontWeight: FontWeight.bold
                //   ),
                // ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1483C2),
                    foregroundColor: Color(0xFFFAFAFA),
                  ),
                  onPressed: () async {
                    if(await Permission.notification.isDenied){
                      final status = await Permission.notification.request();

                      if(status.isDenied){
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.scale,
                            title: "Information",
                            desc: "Aktifkan notifikasi agar bisa menerima reminder.",
                            btnOkText: "Oke",
                            btnOkColor: Color(0xFF1483C2)
                        ).show();
                        return;
                      }
                    }

                    pickDeadlinewithTime(context);
                  }, 
                  child: Text(
                    selectedDeadline != null ? 
                    DateFormat('dd MMM yyyy, HH:mm').format(selectedDeadline!):
                    "pilih deadline",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  )
                ),
              ],
            ),
          ),

            const SizedBox(height: 20),

            Text(
              "Sub Task",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Instrument',
                color: Color(0xFF1483C2),
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start,
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: _subTasks.length,
                itemBuilder: (context, index){
                  final subTask = _subTasks[index];

                  return Row(
                    children: [
                      Checkbox(
                        value: subTask.isDone, 
                        onChanged: (value) => _toggleSubTasksDone(index, value)
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Subtask ${index + 1}",
                            hintStyle: const TextStyle(color: Color(0xFFC2C6CE))
                          ),
                          onChanged: (value) => _updateSubtasksTitle(index, value),
                        ) 
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.grey),
                        onPressed: () => _deleteSubtask(index),
                      )
                    ]
                  );
                }
              ),
            ),

            const SizedBox(height: 40),

            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton.icon(onPressed: _addSubTask, icon: const Icon(Icons.add, color: Color(0xFF1483C2),), label: const Text('Add Sub-task', style: TextStyle(color: Color(0xFF1483C2)))),
                  SizedBox(width: 15,),
                  
                ],  
              )
            ),

            const SizedBox(height: 10),

            ElevatedButton(
                onPressed: _isLoading ? null : _saveTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1483C2),
                  foregroundColor: Color(0xFFFAFAFA),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  )
                ),
                child: _isLoading ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Color(0xFF1483C2),
                    strokeWidth: 2,
                  ),
                ) : const Text("Save"),
              )
          ],
        ),
        ),
    );
  }

}