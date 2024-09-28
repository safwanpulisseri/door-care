import 'package:flutter/material.dart';
import '../../../../core/theme/color/app_color.dart';

class StepperWidget extends StatelessWidget {
  final String titleOne;
  final String titleTwo;
  final String titleThree;
  final Color titleColorOne;
  final Color titleColorTwo;
  final Color titleColorThree;
  final Color circleColorOne;
  final Color circleColorTwo;
  final Color circleColorThree;
  final Icon iconOne;
  final Icon iconTwo;
  final Icon iconThree;

  const StepperWidget({
    super.key,
    required this.titleOne,
    required this.titleTwo,
    required this.titleThree,
    required this.titleColorOne,
    required this.titleColorTwo,
    required this.titleColorThree,
    required this.circleColorOne,
    required this.circleColorTwo,
    required this.circleColorThree,
    required this.iconOne,
    required this.iconTwo,
    required this.iconThree,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: circleColorOne,
              child: iconOne,
            ),
            const SizedBox(height: 4),
            Text(
              titleOne,
              style: TextStyle(
                fontSize: 12,
                color: titleColorOne,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            height: 3,
            width: 80,
            color: AppColor.toneEight.withOpacity(0.6),
          ),
        ),
        Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: circleColorTwo,
              child: iconTwo,
            ),
            const SizedBox(height: 4),
            Text(
              titleTwo,
              style: TextStyle(
                fontSize: 12,
                color: titleColorTwo,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            height: 3,
            width: 80,
            color: AppColor.toneEight.withOpacity(0.6),
          ),
        ),
        Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: circleColorThree,
              child: iconThree,
            ),
            const SizedBox(height: 4),
            Text(
              titleThree,
              style: TextStyle(
                fontSize: 12,
                color: titleColorThree,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
