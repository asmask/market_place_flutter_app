import 'package:flutter/material.dart';
import 'package:market_place_flutter_app/screens/appointment/appointment_screen.dart';
import 'package:market_place_flutter_app/screens/chat/chat_screen.dart';
import 'package:market_place_flutter_app/screens/home/home_screen.dart';
import 'package:market_place_flutter_app/screens/meet/meet_screen.dart';
import 'package:market_place_flutter_app/screens/menu/menu_screen.dart';
import 'package:market_place_flutter_app/screens/menu/profile/profile_screen.dart';
import 'package:market_place_flutter_app/screens/timeSheet/time_sheet_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const AppointmentScreen(),
    const ChatScreen(),
    const TimeSheetsScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.deepPurple,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
          //showSelectedLabels: true,
          //showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Appointments',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.videocam_outlined),
              label: 'Meet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            )
          ]),
    );
  }
}
