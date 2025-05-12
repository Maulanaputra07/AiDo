import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AiDo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      ),
      home: const MyHomePage(title: 'Welcome to AiDo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Container(
          margin: EdgeInsets.only(left: 16.0, top: 7.0),
          child: SizedBox(
            width: 300,
            height: 60,
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 30,
                height: 1.2,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
      ),
      body: Column(
        children: [
          Container(
            // color: Colors.lightGreen,
            padding: EdgeInsets.all(16.0),
            width: double.infinity,
            child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                navButton("home", Icons.home),
                navButton("Tasks", Icons.list_alt),
                navButton("Completed", Icons.check),
                navButton("Smart Tips", Icons.lightbulb),
                navButton("Stats", Icons.bar_chart),
                navButton("Reminders", Icons.notifications),
                navButton("Settings", Icons.settings),
              ],
            ),
          ),
          )
        ],
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget navButton(String label, IconData icon){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton.icon(onPressed: 
      (){

      }, 
      icon: Icon(icon, color: Colors.black),
      label: Text(
        label, 
        style: TextStyle(
          color: Colors.black
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.black),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        
      )),
    );
  }
}