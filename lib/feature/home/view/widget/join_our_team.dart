import 'package:door_care/core/theme/color/app_color.dart';
import 'package:door_care/core/util/png_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JoinOurTeamCard extends StatelessWidget {
  const JoinOurTeamCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: AppColor.toneFour,
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: AssetImage(
              AppPngPath.joinOurTeam,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
