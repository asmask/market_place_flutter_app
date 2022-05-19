import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:market_place_flutter_app/screens/sign_in/sign_in_screen.dart';

class LinkText extends StatelessWidget {
  const LinkText({Key? key, required this.text, required this.linkText})
      : super(key: key);
  final String text;
  final String linkText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const SignInScreen(email: "", password: "")),
            ),
          }, //Navigator.pushNamed(context, SignInScreen.routeName),
          child: Text(
            linkText,
            style: TextStyle(
              color: Theme.of(context).selectedRowColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
