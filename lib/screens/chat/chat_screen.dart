import 'package:flutter/material.dart';
import 'package:market_place_flutter_app/widget/change_theme_button.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Chat',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        actions: const [
          ChangeThemeIconButton(),
        ],
      ),
      body: Container(),
    );
  }
}
