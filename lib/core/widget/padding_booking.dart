import 'package:flutter/material.dart';

class PaddingWidgetBooking extends StatelessWidget {
  final Widget child;

  const PaddingWidgetBooking({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double paddingWidgetHeight = screenHeight * 0.5;

    return Container(
      height: paddingWidgetHeight,
      padding: const EdgeInsets.all(16.0),
      child: child,
    );
  }
}
