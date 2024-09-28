import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../../../core/theme/color/app_color.dart';

class CommentPickerWidget extends StatelessWidget {
  const CommentPickerWidget({
    super.key,
    required this.commentsController,
  });

  final TextEditingController commentsController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.toneTwelve,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8,
            ),
            const Row(
              children: [
                Icon(IconlyLight.message),
                SizedBox(
                  width: 10,
                ),
                Text('COMMENTS'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: TextField(
                controller: commentsController,
                decoration: InputDecoration(
                  hintText: 'Write your Message to Worker',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: AppColor.secondary.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
