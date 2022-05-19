import 'package:flutter/material.dart';
import 'package:market_place_flutter_app/widget/change_theme_button.dart';

class MeetScreen extends StatefulWidget {
  const MeetScreen({Key? key}) : super(key: key);

  @override
  State<MeetScreen> createState() => _MeetScreenState();
}

class _MeetScreenState extends State<MeetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Meet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          actions: const [
            ChangeThemeIconButton(),
          ],
        ),
        body: Container());
  }
}
