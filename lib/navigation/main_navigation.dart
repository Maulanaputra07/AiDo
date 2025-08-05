import 'package:aido/pages/home.dart';
import 'package:aido/pages/list_tasks.dart';
import 'package:flutter/material.dart';
import '../components/bottom_navbar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>{
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    ListTaskPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavBar(
        currentIndex: currentIndex, 
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        }),
      ),
    );
  }
}