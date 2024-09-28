import 'package:flutter/material.dart';
import '../../../../core/theme/color/app_color.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final String navigationTitle;
  final String navigationSubtitle;
  final VoidCallback buttonCallback;
  final VoidCallback textCallback;
  const AuthButton({
    super.key,
    required this.buttonText,
    required this.buttonCallback,
    required this.textCallback,
    required this.navigationTitle,
    required this.navigationSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => buttonCallback(),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          child: Text(
            buttonText,
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => textCallback(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                navigationTitle,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColor.secondary,
                      fontSize: 15,
                    ),
              ),
              Text(
                navigationSubtitle,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColor.primary,
                      fontSize: 15,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
