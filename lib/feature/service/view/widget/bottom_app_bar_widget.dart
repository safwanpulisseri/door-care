import 'package:flutter/material.dart';
import '../../../../core/theme/color/app_color.dart';

class BottomAppBarWidget extends StatelessWidget {
  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback onLeftButtonPressed;
  final VoidCallback onRightButtonPressed;

  const BottomAppBarWidget(
      {super.key,
      required this.leftButtonText,
      required this.rightButtonText,
      required this.onLeftButtonPressed,
      required this.onRightButtonPressed});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColor.textfield,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ElevatedButton(
            onPressed: onLeftButtonPressed,
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(const Size(200, 50)),
              backgroundColor: WidgetStateProperty.all(AppColor.textfield),
              foregroundColor:
                  WidgetStateProperty.all(AppColor.secondary.withOpacity(0.7)),
              side: WidgetStateProperty.all(BorderSide(
                color: AppColor.toneThree.withOpacity(0.5),
                width: 2,
              )),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            child: Text(
              leftButtonText,
            ),
          ),
          ElevatedButton(
            onPressed: onRightButtonPressed,
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(const Size(200, 50)),
              backgroundColor: WidgetStateProperty.all(AppColor.primary),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            child: Text(rightButtonText),
          ),
        ],
      ),
    );
  }
}
