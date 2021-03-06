import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final bool isEdit;
  final String imagePath;
  final VoidCallback onClicked;
  const ProfileWidget(
      {Key? key,
      this.isEdit = false,
      required this.imagePath,
      required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        buildImage(),
        Positioned(
          child: buildEditIcon(Colors.deepPurple, context),
          bottom: 0,
          right: 4,
        ),
      ],
    ));
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);
    return ClipOval(
        child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image: image,
              fit: BoxFit.cover,
              width: 128,
              height: 128,
              child: InkWell(
                onTap: onClicked,
              ),
            )));
  }

  Widget buildEditIcon(Color color, BuildContext context) => buildCirle(
        color: Colors.white,
        all: 3,
        child: buildCirle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );
  Widget buildCirle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ));
}
