import 'package:door_care/core/theme/color/app_color.dart';
import 'package:door_care/feature/navigation_menu/page/home_navigation_menu.dart';
import 'package:door_care/feature/service/bloc/enter_details_bloc/enter_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/widget/toastifiaction_widget.dart';
import '../../../auth/view/widget/loading_dialog.dart';
import '../../../home/data/model/fetch_all_service_model.dart';
import '../widget/bottom_app_bar_widget.dart';
import '../widget/circle_avathar_widget.dart';
import '../widget/comment_picker_widget.dart';
import '../widget/date_picker_widget.dart';
import '../widget/time_picker_widget.dart';
import 'comepleted_book_service.dart';

class EnterDetailsBookService extends StatefulWidget {
  final FetchAllServiceModel service;
  final double latitude;
  final double longitude;

  const EnterDetailsBookService({
    super.key,
    required this.service,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<EnterDetailsBookService> createState() =>
      _EnterDetailsBookServiceState();
}

class _EnterDetailsBookServiceState extends State<EnterDetailsBookService> {
  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  TextEditingController commentsController = TextEditingController();

  void _updateDate(DateTime? date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _updateStartTime(TimeOfDay? time) {
    setState(() {
      selectedStartTime = time;
    });
  }

  void _updateEndTime(TimeOfDay? time) {
    setState(() {
      selectedEndTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EnterDetailsBloc, EnterDetailsState>(
      listener: (context, state) {
        if (state is EnterDetailsLoadingState) {
          LoadingDialog.show(context);
        } else if (state is EnterDetailsSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const CompletedBookService(),
            ),
            (route) => false,
          );
          ToastificationWidget.show(
            context: context,
            type: ToastificationType.success,
            title: 'Success',
            description: 'Successfully Booked a Service!',
          );
        } else if (state is EnterDetailsFailState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => HomeNavigationMenu(),
            ),
            (route) => false,
          );
          Navigator.pop(context);
          ToastificationWidget.show(
            context: context,
            type: ToastificationType.error,
            title: 'Error',
            description: 'Failed to book a service. Please try again.',
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const StepperWidget(
                  titleOne: 'Location',
                  titleTwo: 'Details',
                  titleThree: 'Success',
                  titleColorOne: AppColor.toneThree,
                  titleColorTwo: AppColor.secondary,
                  titleColorThree: AppColor.toneThree,
                  circleColorOne: AppColor.toneFive,
                  circleColorTwo: AppColor.primary,
                  circleColorThree: AppColor.toneFive,
                  iconOne: Icon(
                    FontAwesomeIcons.check,
                    color: AppColor.background,
                  ),
                  iconTwo: Icon(
                    FontAwesomeIcons.check,
                    color: AppColor.background,
                  ),
                  iconThree: Icon(
                    Icons.add,
                    color: AppColor.background,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      DatePickerWidget(
                        onDateSelected: _updateDate, // Pass the callback
                      ),
                      const SizedBox(height: 20),
                      TimePickerWidget(
                        onStartTimeSelected: _updateStartTime,
                        onEndTimeSelected: _updateEndTime,
                      ),
                      const SizedBox(height: 20),
                      CommentPickerWidget(
                        commentsController: commentsController,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBarWidget(
          leftButtonText: 'Back',
          rightButtonText: 'Finish',
          onLeftButtonPressed: () {
            Navigator.of(context).pop();
          },
          onRightButtonPressed: () {
            if (selectedDate != null &&
                selectedStartTime != null &&
                selectedEndTime != null) {
              // Format the selected date and time for the event
              final formattedDate =
                  DateFormat('yyyy-MM-dd').format(selectedDate!);
              final formattedStartTime = selectedStartTime!.format(context);
              final formattedEndTime = selectedEndTime!.format(context);
              // Pass the data to the BLoC event
              context.read<EnterDetailsBloc>().add(
                    EnterServiceDetailsEvent(
                      serviceName: widget.service.serviceName,
                      serviceImg: widget.service.serviceImg,
                      firstHourCharge: widget.service.firstHourCharge,
                      laterHourCharge: widget.service.laterHourCharge,
                      comments: commentsController.text,
                      date: formattedDate,
                      startTime: formattedStartTime,
                      endTime: formattedEndTime,
                      latitude: widget.latitude,
                      longitude: widget.longitude,
                    ),
                  );
            } else {
              ToastificationWidget.show(
                context: context,
                type: ToastificationType.error,
                title: 'Error',
                description: 'Please select date, start time, and end time.',
              );
            }
          },
        ),
      ),
    );
  }
}
