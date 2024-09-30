import 'package:door_care/feature/auth/auth_bloc/auth_bloc.dart';
import 'package:door_care/feature/navigation_menu/page/home_navigation_menu.dart';
import 'package:door_care/feature/onboarding/view/page/onboarding_home.dart';
import 'package:door_care/core/theme/color/app_color.dart';
import 'package:door_care/core/util/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeNavigationMenu(),
            ),
            (route) => false,
          );
        }
        if (state is AuthFailState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const OnboardingScreen(),
            ),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const Spacer(flex: 4),
                SvgPicture.asset(AppSvgPath.splashLogo),
                const Spacer(
                  flex: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
