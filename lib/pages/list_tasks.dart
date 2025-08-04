import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListTaskPage extends ConsumerWidget {
  const ListTaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyListTaskPage();
  }
}

class MyListTaskPage extends ConsumerStatefulWidget {
  const MyListTaskPage({super.key});

  @override
  ConsumerState<MyListTaskPage> createState() => _MyListPageState();
}

class _MyListPageState extends ConsumerState<MyListTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("INI PAGE LIST TAKS"),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}