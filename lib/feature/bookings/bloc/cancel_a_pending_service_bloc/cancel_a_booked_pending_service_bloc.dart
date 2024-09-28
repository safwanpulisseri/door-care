import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repository/cancel_a_booked_pending_service_repo.dart';
part 'cancel_a_booked_pending_service_event.dart';
part 'cancel_a_booked_pending_service_state.dart';

class CancelABookedPendingServiceBloc extends Bloc<
    CancelABookedPendingServiceEvent, CancelABookedPendingServiceState> {
  final CancelABookedPendingServiceRepo _cancelABookedPendingServiceRepo;
  CancelABookedPendingServiceBloc(this._cancelABookedPendingServiceRepo)
      : super(CancelABookedPendingServiceInitialState()) {
    on<CancelBookedPendingServiceEvent>((event, emit) async {
      emit(CancelABookedPendingServiceLoadingState());
      try {
        var response =
            await _cancelABookedPendingServiceRepo.cancelABookedPendingServices(
          bookingId: event.bookingId,
        );
        if (response.statusCode == 200) {
          emit(CancelABookedPendingServiceSuccessState());
        } else {
          emit(CancelABookedPendingServiceFailState());
          log('cancel a booked Service failed: ${response.statusCode}');
          throw Exception('cancel a booked Service failed');
        }
      } catch (e) {
        log(e.toString());
        emit(CancelABookedPendingServiceFailState());
      }
    });
  }
}
