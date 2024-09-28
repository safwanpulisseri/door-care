part of 'cancel_a_booked_pending_service_bloc.dart';

sealed class CancelABookedPendingServiceEvent extends Equatable {
  const CancelABookedPendingServiceEvent();

  @override
  List<Object> get props => [];
}

final class CancelBookedPendingServiceEvent
    extends CancelABookedPendingServiceEvent {
  final String bookingId;
  const CancelBookedPendingServiceEvent({
    required this.bookingId,
  });
}
