import 'package:flutter/material.dart';
import 'package:market_place_flutter_app/widget/change_theme_button.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Menu',
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
