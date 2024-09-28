import 'package:door_care/feature/navigation_menu/page/home_navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/jason_asset.dart';
import '../widget/circle_avathar_widget.dart';

class CompletedBookService extends StatelessWidget {
  const CompletedBookService({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => HomeNavigationMenu(),
        ),
      );
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const StepperWidget(
              titleOne: 'Location',
              titleTwo: 'Details',
              titleThree: 'Success',
              titleColorOne: AppColor.toneThree,
              titleColorTwo: AppColor.toneThree,
              titleColorThree: AppColor.secondary,
              circleColorOne: AppColor.toneFive,
              circleColorTwo: AppColor.toneFive,
              circleColorThree: AppColor.primary,
              iconOne: Icon(
                FontAwesomeIcons.check,
                color: AppColor.background,
              ),
              iconTwo: Icon(
                FontAwesomeIcons.check,
                color: AppColor.background,
              ),
              iconThree: Icon(
                FontAwesomeIcons.check,
                color: AppColor.background,
              ),
            ),
            Spacer(
              flex: 2,
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Lottie.asset(
                AppJasonPath.verifyIcon,
                // repeat: false, // Ensure the animation plays only once
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              "Booking Successful!",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.secondary,
                    fontSize: 27,
                  ),
              textAlign: TextAlign.center,
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              "Your booking has been initiated successfully.\nPlease wait for the worker's approval.\nYou will be redirected shortly.",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColor.secondary,
                    fontSize: 16,
                  ),
              textAlign: TextAlign.center,
            ),
            const Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
