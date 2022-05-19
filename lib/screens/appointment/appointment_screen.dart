import 'package:flutter/material.dart';
import 'package:market_place_flutter_app/widget/change_theme_button.dart';
import 'package:market_place_flutter_app/widget/my_calendar.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Appointments',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        actions: const [
          ChangeThemeIconButton(),
        ],
      ),
      body: const MyCalendar(),
    );
  }
}
