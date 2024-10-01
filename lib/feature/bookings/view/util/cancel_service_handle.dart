import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widget/alert_dialogue_widget.dart';
import '../../bloc/cancel_a_pending_service_bloc/cancel_a_booked_pending_service_bloc.dart';

final class CancelServiceHandle {
  CancelServiceHandle._();

  static void showCancelServiceDialog(BuildContext context,String bookingId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'Confirm Cancel Service',
          content: 'Are you sure you want to cancel?',
          buttonText: 'Yes',
          onPressed: () {
            Navigator.of(context).pop(); 
             context.read<CancelABookedPendingServiceBloc>().add(
                            CancelBookedPendingServiceEvent(
                            bookingId: bookingId,
                            ),
                          );      
          },
        );
      },
    );
  }
}
