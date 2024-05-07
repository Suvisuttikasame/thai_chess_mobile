import 'package:flutter/material.dart';

class MyDrawerButton extends StatelessWidget {
  final Color iconColor;

  const MyDrawerButton({
    super.key,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.menu,
        color: iconColor,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
