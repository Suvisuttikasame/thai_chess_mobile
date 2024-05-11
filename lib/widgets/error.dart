import 'package:flutter/material.dart';

class ErrorCustom extends StatelessWidget {
  final String errorMessage;

  const ErrorCustom({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          size: 100,
          color: Colors.white,
        ),
        const SizedBox(height: 20),
        Text(
          'Oops! Something went wrong.',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          errorMessage,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
