import 'package:door_care/core/util/app_padding.dart';
import 'package:flutter/material.dart';

class PaddingWidget extends StatelessWidget {
  final double padding;
  final Widget child;
  const PaddingWidget(
      {this.padding = AppPadding.auth, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: child,
    );
  }
}
