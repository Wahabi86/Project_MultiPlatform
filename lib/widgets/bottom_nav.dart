import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project_uts/ui/home_page.dart';
import 'package:project_uts/ui/search_page.dart';
import 'package:project_uts/ui/profile_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.transparent,
        color: Colors.grey[900]!,
        animationDuration: Duration(milliseconds: 300),
        items: [
          Icon(Icons.home,
              color: _selectedIndex == 0 ? Color(0xFFFFC700) : Colors.white),
          Icon(Icons.search,
              color: _selectedIndex == 1 ? Color(0xFFFFC700) : Colors.white),
          Icon(Icons.person,
              color: _selectedIndex == 2 ? Color(0xFFFFC700) : Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
