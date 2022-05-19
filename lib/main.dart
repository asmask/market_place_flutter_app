import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:market_place_flutter_app/screens/introduction/introduction_animation_screen.dart';
import 'package:market_place_flutter_app/screens/introduction/loading_screen.dart';
import 'package:market_place_flutter_app/screens/sign_in/sign_in_screen.dart';
import 'package:market_place_flutter_app/widget/change_theme_button.dart';
import 'package:provider/provider.dart';

import 'preferences/client_preferences.dart';
import 'provider/theme_provider.dart';

void main() async {
  //init preferences
  //await ClientPreferences.init();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            title: 'Market Place Demo',
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            debugShowCheckedModeBanner: false,
            home: const SignInScreen(email: "", password: ""),
          );
        },
      );
}
