import 'package:flutter/material.dart';

class BodyLayout extends StatelessWidget {
  const BodyLayout({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.onPrimary,
            Theme.of(context).colorScheme.primary,
          ],
        ),
      ),
      child: child,
    );
  }
}
