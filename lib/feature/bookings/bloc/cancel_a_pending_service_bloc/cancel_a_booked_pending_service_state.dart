part of 'cancel_a_booked_pending_service_bloc.dart';

sealed class CancelABookedPendingServiceState extends Equatable {
  const CancelABookedPendingServiceState();

  @override
  List<Object> get props => [];
}

final class CancelABookedPendingServiceInitialState
    extends CancelABookedPendingServiceState {}

final class CancelABookedPendingServiceLoadingState
    extends CancelABookedPendingServiceState {}

final class CancelABookedPendingServiceSuccessState
    extends CancelABookedPendingServiceState {}

final class CancelABookedPendingServiceFailState
    extends CancelABookedPendingServiceState {}
