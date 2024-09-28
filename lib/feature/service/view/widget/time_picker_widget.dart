import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../../../core/theme/color/app_color.dart';

class TimePickerWidget extends StatefulWidget {
  final void Function(TimeOfDay?) onStartTimeSelected;
  final void Function(TimeOfDay?) onEndTimeSelected;

  const TimePickerWidget({
    super.key,
    required this.onStartTimeSelected,
    required this.onEndTimeSelected,
  });

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: AppColor.primary),
            // textTheme: const TextTheme().copyWith(
            //   bodyLarge: const TextStyle(color: AppColor.secondary),
            // ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _selectedStartTime = picked;
          widget.onStartTimeSelected(picked);
        } else {
          _selectedEndTime = picked;
          widget.onEndTimeSelected(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _selectTime(context, true),
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.toneTwelve,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(IconlyLight.timeSquare),
                    SizedBox(width: 10),
                    Text('Start Time')
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 45),
                    Text(
                      _selectedStartTime != null
                          ? _selectedStartTime!.format(context)
                          : 'Select your Start Time',
                      style: TextStyle(
                        color: AppColor.secondary.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => _selectTime(context, false),
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.toneTwelve,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(IconlyLight.timeSquare),
                    SizedBox(width: 10),
                    Text('End Time')
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 45),
                    Text(
                      _selectedEndTime != null
                          ? _selectedEndTime!.format(context)
                          : 'Select your End Time',
                      style: TextStyle(
                        color: AppColor.secondary.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
