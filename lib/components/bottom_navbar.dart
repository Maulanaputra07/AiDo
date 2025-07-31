import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            backgroundColor: Color(0xFF1483C2),
            currentIndex: currentIndex,
            onTap: onTap,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Color(0xFFFAFAFA),
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == 0 ? Color(0xFFFAFAFA) : Colors.transparent
                  ),
                  padding: EdgeInsets.all(7),
                  child: Image.asset(
                  'assets/icons/home.png',
                  width: 30,
                  height: 30,
                  color: currentIndex == 0 ? Color(0xFF1483C2) : Colors.white70,
                ),
                ),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.task),
                label: 'Task'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings'
              ),
            ]
          ),
        )
      )
    );
  }
}