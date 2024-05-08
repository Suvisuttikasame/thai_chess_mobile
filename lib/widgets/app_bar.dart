import 'package:flutter/material.dart';
import 'package:thai_chess_mobile/pages/home_page.dart';
import 'package:thai_chess_mobile/widgets/drawer_button.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = 80.0;

  const MyAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: ModalRoute.of(context)?.settings.name == HomePage.route
          ? const MyDrawerButton(iconColor: Colors.amber)
          : null,
      automaticallyImplyLeading: false,
      toolbarHeight: height,
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.onSecondary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
        ),
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Chess',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
              TextSpan(
                  text: ' Pro',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.amberAccent,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(2, 2),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
