import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'change_theme_button.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: const [ChangeThemeIconButton()],
  );
}
