import 'package:flutter/material.dart';
import 'package:market_place_flutter_app/widget/default_button.dart';
import 'package:market_place_flutter_app/widget/app_bar.dart';
import 'package:market_place_flutter_app/widget/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          padding: const EdgeInsets.all(50.0),
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
                //isEdit: true,
                imagePath:
                    "https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop", //user.imagePath
                onClicked: () async {} //go to the edi page
                ),
            const SizedBox(
              height: 24,
            ),
            buildName('Asma Skhiri', 'asma@client.com'),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: buildUpgradeButton(),
            ),
          ],
        ));
  }

  //pass Object user
  Widget buildName(String name, String email) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          email,
          style: TextStyle(color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget buildUpgradeButton() => Padding(
        padding: const EdgeInsets.all(20),
        child: DefaultButton(
          text: "Upgrade To PRO",
          press: () {
            debugPrint('ggg');
          },
        ),
      );
}
