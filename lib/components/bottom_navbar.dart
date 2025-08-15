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
              buildItem(0, 'assets/icons/home.png'),
              buildItem(1, 'assets/icons/task.png'),
              buildItem(2, 'assets/icons/profile.png'),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem buildItem(int index, String assetPath){
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentIndex == index ? Color(0xFFFAFAFA) : Colors.transparent
        ),
        padding: EdgeInsets.all(4),
        child: Image.asset(
          assetPath,
          width: 50,
          height: 50,
          color: currentIndex == index ? Color(0xFF1483C2) : Color(0xFFFAFAFA),
        ),
      ),
      label: ''
    );
  }
}
