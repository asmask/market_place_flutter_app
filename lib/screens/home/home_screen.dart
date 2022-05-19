import 'package:flutter/material.dart';
import 'package:market_place_flutter_app/screens/home/body.dart';
import 'package:market_place_flutter_app/widget/change_theme_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).secondaryHeaderColor,
        automaticallyImplyLeading: false,
        title: const Text('Home',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        actions: const [
          ChangeThemeIconButton(),
        ],
      ),
      body: const Body(),
    );
  }
}
