import 'package:flutter/material.dart';

class AuthTitleWidget extends StatelessWidget {
  final String title;
  const AuthTitleWidget({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 35,
          ),
      textAlign: TextAlign.center,
    );
  }
}
