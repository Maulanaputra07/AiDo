import 'package:aido/pages/home.dart';
import 'package:aido/pages/list_tasks.dart';
import 'package:flutter/material.dart';

// class BottomNavBar extends StatefulWidget{
//   final int currentIndex;
//   final Function(int) onTap;

//   const BottomNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });

//   @override
//   State<BottomNavBar> CreateState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar>{
//   int currentIndex = 0;

//   final List<Widget> pages = const [
//     HomePage(),         // dari home.dart
//     ListTaskPage(),     // profil user
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: currentIndex,
//         children: pages,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         onTap: (index) => setState(() => currentIndex = index),
//         items: [
//           BottomNavigationBarItem(
//             icon: buildNavIcon(0, 'assets/icons/home.png'),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: buildNavIcon(1, 'assets/icons/task.png'),
//             label: 'Task',
//           ),
//           BottomNavigationBarItem(
//             icon: buildNavIcon(2, 'assets/icons/profile.png'),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildNavIcon(int index, String assetPath) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: currentIndex == index ? Color(0xFFFAFAFA) : Colors.transparent,
//       ),
//       padding: const EdgeInsets.all(4),
//       child: Image.asset(
//         assetPath,
//         width: 50,
//         height: 50,
//         color: currentIndex == index ? Color(0xFF1483C2) : Color(0xFFFAFAFA),
//       ),
//     );
//   }
// }

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