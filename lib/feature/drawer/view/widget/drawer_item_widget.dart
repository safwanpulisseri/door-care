import 'package:flutter/material.dart';
import '../../../../core/theme/color/app_color.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColor.background),
      title: Text(
        text,
        style: const TextStyle(color: AppColor.background),
      ),
      onTap: onTap,
    );
  }
}
