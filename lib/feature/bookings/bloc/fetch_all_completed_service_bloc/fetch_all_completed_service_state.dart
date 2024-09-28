part of 'fetch_all_completed_service_bloc.dart';

sealed class FetchAllCompletedServiceState extends Equatable {
  const FetchAllCompletedServiceState();

  @override
  List<Object> get props => [];
}

final class FetchAllCompletedServiceInitialState
    extends FetchAllCompletedServiceState {}

final class FetchAllCompletedServiceLoadingState
    extends FetchAllCompletedServiceState {}

final class FetchAllCompletedServiceSuccessState
    extends FetchAllCompletedServiceState {
  final List<FetchAllBookedServiceModel> fetchAllCompletedServiceModel;
  const FetchAllCompletedServiceSuccessState({
    required this.fetchAllCompletedServiceModel,
  });
}

final class FetchAllCompletedServiceFailState
    extends FetchAllCompletedServiceState {}
