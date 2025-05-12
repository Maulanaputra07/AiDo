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
        backgroundColor: Colors.white,
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
      body: Stack(
        children: [
          // === Main Scroll Content === 
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(12),
                            // border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total tasks",
                                style: TextStyle(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "0",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 100,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.circular(12),
                            // border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Completed tasks",
                                style: TextStyle(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "0",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Row(
    children: [
      // Bagian kiri dengan Plan for the day
      Expanded(
        flex: 2,
        child: Container(
          height: 200,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(17),
              topRight: Radius.circular(17),
              bottomRight: Radius.circular(17),
            ),
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Plan for the day",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Task a",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Task b",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Task c",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),

      SizedBox(width: 16),

      // Bagian kanan dengan dua Completed tasks
      Expanded(
        flex: 1,
        child: Column(
          children: [
            Container(
              // container ini akan saya gunakan untuk tanggal hari ini
              height: 100,
              width: 500,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Senin",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                      "12 Mei 2025",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),

            SizedBox(height: 16),

            Container(
              // container ini akan saya gunakan untuk jam saat ini
              height: 100,
              width: 500,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "(jam saat ini)",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),

              ],
            ),
          ),
          
          // SizedBox(height: 16),
          
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'add',
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(Icons.add, color: Colors.black),
                ),
                SizedBox(width: 18),
                FloatingActionButton(
                  heroTag: 'mic',
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(Icons.mic, color: Colors.black),
                )
              ],
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