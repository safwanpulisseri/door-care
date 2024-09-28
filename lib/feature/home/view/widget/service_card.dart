// service_card.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/color/app_color.dart';

class ServiceCard extends StatelessWidget {
  final String image;
  final String title;

  const ServiceCard({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 160,
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(image,
                  fit: BoxFit.cover, width: 240, height: 150)),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColor.secondary,
                  fontSize: 17,
                ),
          ),
        ],
      ),
    );
  }
}
