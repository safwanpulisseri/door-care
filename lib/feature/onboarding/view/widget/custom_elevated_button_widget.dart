import 'package:flutter/material.dart';
import '../../../../core/theme/color/app_color.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? width;
  final double? height;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width ?? double.infinity, height ?? 50),
        backgroundColor: backgroundColor ?? AppColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: textColor ?? AppColor.background,
              fontSize: fontSize ?? 17,
            ),
      ),
    );
  }
}
