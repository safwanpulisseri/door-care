import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/theme/color/app_color.dart';
import '../../../../../core/util/jason_asset.dart';
import '../../../../navigation_menu/page/home_navigation_menu.dart';

class PaymentFailure extends StatelessWidget {
  const PaymentFailure({super.key});

  @override
  Widget build(BuildContext context) {
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
              AppJasonPath
                  .failedToFetch, // Use an appropriate failure animation
              // repeat: false, // Ensure the animation plays only once
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            "Payment Failed",
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
            "There was an issue processing your payment. Please try again or contact support.",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColor.secondary,
                  fontSize: 16,
                ),
            textAlign: TextAlign.center,
          ),
          const Spacer(
            flex: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) =>
                        HomeNavigationMenu(), // Change this to the page you want to navigate to
                  ),
                );
              },
              child: const Text('Retry'),
            ),
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
