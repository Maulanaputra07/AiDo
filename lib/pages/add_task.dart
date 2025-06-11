import 'package:flutter/material.dart';

class AddTaskPage extends StatelessWidget{
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: const Text("AiDo")),
      body: Center(
        child: ElevatedButton(onPressed: (){
          // Navigator.push(context, MaterialPageRoute(builder: (context) => Main))
        }, child: const Text("Save")),
      ),
    );
  }
}