part of 'fetch_all_completed_service_bloc.dart';

sealed class FetchAllCompletedServiceEvent extends Equatable {
  const FetchAllCompletedServiceEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllPaymentEnteredServiceEvent
    extends FetchAllCompletedServiceEvent {}
