part of 'fetch_all_pending_services_bloc.dart';

sealed class FetchAllPendingServicesEvent extends Equatable {
  const FetchAllPendingServicesEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllBookedPendingServicesEvent
    extends FetchAllPendingServicesEvent {}
