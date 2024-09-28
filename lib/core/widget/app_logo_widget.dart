import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../util/svg_asset.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AppSvgPath.mainLogo);
  }
}
