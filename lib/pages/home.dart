// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '../providers/task_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyHomePage(title: "Welcome to AiDo");
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  final String title;
  // final AsyncValue<QuerySnapshot> taskStream;
  const MyHomePage({super.key, required this.title});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {

  Map<String, String> getFormattedDate(){
    final now = DateTime.now();

    String dayName = DateFormat.EEEE('id_ID').format(now); 
    String date = DateFormat.yMMMMd('id_ID').format(now); 

    return {
      'dayName' : dayName,
      'date' : date,
    };
  }


  @override
  Widget build(BuildContext context) {
  final dateParts = getFormattedDate();
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        toolbarHeight: 100,
        title: Container(
          margin: EdgeInsets.only(left: 16.0, top: 7.0),
          child: SizedBox(
            width: 300,
            height: 60,
            child: Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
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
                    // color: Colors.white,
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
                              Consumer(builder: (context, ref, _) {
                                final taskStream= ref.watch(taskStreamProvider(false));

                                return taskStream.when(
                                  data: (tasks) => Text("${tasks.length}",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  loading: () => const Text(
                                    "...",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  error: (err, stack) {
                                    // print("error : ${err}");
                                    return Text("!", style: TextStyle(color: Colors.red));
                                  }
                                );
                              }),
                              // Text(
                              //   "0",
                              //   style: TextStyle(
                              //     fontSize: 24,
                              //     fontWeight: FontWeight.bold
                              //   ),
                              // )
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
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Consumer(
                            builder:(context, ref, _) {
                              final taskStream = ref.watch(taskStreamProvider(true));

                              return taskStream.when(
                                data: (tasks){
                                  if(tasks.isEmpty) {
                                    return Center(
                                      child: Text(
                                        "Tidak ada task hari ini",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold
                                        ),
                                        ),
                                    );
                                    // const Text(
                                    //   "Tidak ada task untuk hari ini",
                                    //   style: TextStyle(
                                    //     fontSize: 30
                                    //   ),
                                    // );
                                  }

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Task untuk hari ini",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: tasks.length,
                                          itemBuilder: (context, index){
                                            final task = tasks[index];
                                            return Row(
                                              children: [
                                                Icon(
                                                  task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
                                                  size: 19,
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  task.title,
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                }, 
                                loading: () => const CircularProgressIndicator(),
                                error: (e, _) => Text('error : $e'), 
                                );
                            },
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
                                    "${dateParts['dayName']}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                      "${dateParts['date']}",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                ],
                              ),
                            ),

                            SizedBox(height: 16),

                            Container(
                              // container ini akan saya gunakan untuk jam saat ini
                              height: 80,
                              width: 500,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: RealTimeClock(),
                              )
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
                  onPressed: () {
                    Navigator.pushNamed(context, '/addtask');
                  },
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
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
        backgroundColor: Colors.amber[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        
      )),
    );
  }
}

class RealTimeClock extends StatefulWidget{
  const RealTimeClock({super.key});

  @override
  State<RealTimeClock> createState() => _RealtimeClockState();
}

class _RealtimeClockState extends State<RealTimeClock> {
  late String _currentTime;
  late Timer _timer;

  @override
  void initState(){
    super.initState();
    _currentTime = _getCurrentTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _getCurrentTime();
      });
    });
  }

  String _getCurrentTime(){
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    
  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Text(
      _currentTime,
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}

