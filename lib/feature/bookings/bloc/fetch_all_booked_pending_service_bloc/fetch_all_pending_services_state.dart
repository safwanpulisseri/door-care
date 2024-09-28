part of 'fetch_all_pending_services_bloc.dart';

sealed class FetchAllPendingServicesState extends Equatable {
  const FetchAllPendingServicesState();

  @override
  List<Object> get props => [];
}

final class FetchAllPendingServicesInitialState
    extends FetchAllPendingServicesState {}

final class FetchAllPendingServicesLoadingState
    extends FetchAllPendingServicesState {}

final class FetchAllPendingServicesSuccessState
    extends FetchAllPendingServicesState {
  final List<FetchAllBookedServiceModel> fetchAllBookedServiceModel;
  const FetchAllPendingServicesSuccessState({
    required this.fetchAllBookedServiceModel,
  });
}

final class FetchAllPendingServicesFailState
    extends FetchAllPendingServicesState {}
