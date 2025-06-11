import 'package:aido/pages/add_task.dart';
import 'package:aido/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: Theme,
      home: const HomePage(),
      routes: {
        '/addtask': (context) => const AddTaskPage(),
      },
    );
  }
}