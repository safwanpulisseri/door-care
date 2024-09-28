import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final int dotsCount;
  final int position;
  final DotsDecorator decorator;

  const DotsIndicator({
    super.key,
    required this.dotsCount,
    required this.position,
    required this.decorator,
  });

  Color _getDotColor(int index) {
    int relativeIndex = (index - position + dotsCount) % dotsCount;

    // Active dot (current position)
    if (relativeIndex == 0) {
      return decorator.activeColor;
    }
    // Case when current dot is at the last position
    else if (position == dotsCount - 1 && relativeIndex == dotsCount - 1) {
      return decorator.baseColor
          .withOpacity(0.7); // Lighter for previous dot (left of last)
    }
    // Next dot becomes lighter when the last dot is active
    else if (position == dotsCount - 1 && relativeIndex == 1) {
      return decorator.baseColor
          .withOpacity(0.4); // Even lighter for next dot (right of last)
    }
    // Case when current dot is at the first position
    else if (position == 0 && relativeIndex == 1) {
      return decorator.baseColor
          .withOpacity(0.7); // Lighter for next dot (right of first)
    }
    // Case when first position is active, the next-next dot becomes lighter
    else if (position == 0 && relativeIndex == 2) {
      return decorator.baseColor
          .withOpacity(0.4); // Even lighter for next-next dot (right of first)
    }
    // Case when current dot is at the middle position
    else if (relativeIndex == 1 || relativeIndex == dotsCount - 1) {
      return decorator.baseColor.withOpacity(
          0.7); // Slightly lighter for dots next to active (left and right)
    }
    // General distant dots
    else {
      return decorator.baseColor
          .withOpacity(0.2); // Very light for distant dots
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(dotsCount, (index) {
        return Container(
          width: index == position
              ? decorator.activeSize.width
              : decorator.size.width,
          height: index == position
              ? decorator.activeSize.height
              : decorator.size.height,
          margin: decorator.spacing,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: _getDotColor(index),
            borderRadius: decorator.shape?.borderRadius,
          ),
        );
      }),
    );
  }
}

class DotsDecorator {
  final Color baseColor;
  final Color activeColor;
  final Size size;
  final Size activeSize;
  final RoundedRectangleBorder? shape;
  final EdgeInsetsGeometry spacing;

  DotsDecorator({
    required this.baseColor,
    required this.activeColor,
    required this.size,
    required this.activeSize,
    this.shape,
    required this.spacing,
  });
}
