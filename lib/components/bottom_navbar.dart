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
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1483C2),
          borderRadius: BorderRadius.circular(30)
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: currentIndex,
          onTap: onTap,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Color(0xFF1483C2),
          unselectedItemColor: Color(0xFFFAFAFA),
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == 0 ? Color(0xFFFAFAFA) : Colors.transparent
                  ),
                  padding: EdgeInsets.all(4),
                  child: Image.asset(
                  'assets/icons/home.png',
                  width: 50,
                  height: 50,
                  color: currentIndex == 0 ? Color(0xFF1483C2) : Colors.white70,
                ),
                ),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == 1 ? Color(0xFFFAFAFA) : Colors.transparent
                  ),
                  padding: EdgeInsets.all(4),
                  child: Image.asset(
                    'assets/icons/task.png',
                    width: 50,
                    height: 50,
                    color: currentIndex == 1 ? Color(0xFF1483C2) : Color(0xFFFAFAFA),
                  ),
                ),
                label: 'Task'
              ),
              BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == 2 ? Color(0xFFFAFAFA) : Colors.transparent
                  ),
                  padding: EdgeInsets.all(4),
                  child: Image.asset(
                    'assets/icons/profile.png',
                    width: 50,
                    height: 50,
                    color: currentIndex == 2 ? Color(0xFF1483C2) : Color(0xFFFAFAFA),
                  ),
                ),
                label: 'Profile',
              ),
          ],
        ),
      ),
    );
  }
}