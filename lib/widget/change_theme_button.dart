import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place_flutter_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
        activeColor: Colors.deepPurpleAccent,
        activeTrackColor: Colors.deepPurple,
        inactiveThumbColor: Colors.deepPurple,
        value: themeProvider.isDarkMode,
        onChanged: (value) {
          final provider = Provider.of<ThemeProvider>(
            context,
            listen: false,
          );
          provider.toggleTheme(value);
        });
  }
}

class ChangeThemeIconButton extends StatelessWidget {
  const ChangeThemeIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark_icon = CupertinoIcons.moon_stars;
    final light_icon = CupertinoIcons.sun_max;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDark = themeProvider.isDarkMode;

    return IconButton(
      icon: themeProvider.isDarkMode ? Icon(light_icon) : Icon(dark_icon),
      onPressed: () {
        final provider = Provider.of<ThemeProvider>(
          context,
          listen: false,
        );
        if (isDark) {
          provider.toggleTheme(false);
        } else {
          provider.toggleTheme(true);
        }
      },
    );
  }
}
