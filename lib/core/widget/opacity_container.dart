import 'package:flutter/material.dart';

import '../theme/color/app_color.dart';

class OpacityContainer extends StatelessWidget {
  const OpacityContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.primary.withOpacity(0.7)),
      height: 25,
      width: 5,
    );
  }
}
