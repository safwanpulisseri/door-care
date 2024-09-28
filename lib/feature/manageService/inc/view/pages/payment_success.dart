import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/theme/color/app_color.dart';
import '../../../../../core/util/jason_asset.dart';
import '../../../../navigation_menu/page/home_navigation_menu.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => HomeNavigationMenu(),
          ),
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Spacer(
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
            "Payment Successful!",
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
            "Your payment was processed successfully. You will be redirected shortly.",
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
    );
  }
}
