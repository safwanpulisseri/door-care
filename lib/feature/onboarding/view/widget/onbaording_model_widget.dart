import 'package:flutter/material.dart';
import '../../../../core/theme/color/app_color.dart';
import '../model/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPage({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: AppColor.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Image.asset(
              model.image,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            model.title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            model.subtitle,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.black,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
