import 'package:flutter/material.dart';

@immutable
final class OnboardingModel {
  final String image;
  final String title;
  final String subtitle;

  const OnboardingModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
