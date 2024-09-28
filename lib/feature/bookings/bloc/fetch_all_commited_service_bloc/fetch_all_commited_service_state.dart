part of 'fetch_all_commited_service_bloc.dart';

sealed class FetchAllCommitedServiceState extends Equatable {
  const FetchAllCommitedServiceState();

  @override
  List<Object> get props => [];
}

final class FetchAllCommitedServiceInitialState
    extends FetchAllCommitedServiceState {}

final class FetchAllCommitedServiceLoadingState
    extends FetchAllCommitedServiceState {}

final class FetchAllCommitedServiceSuccessState
    extends FetchAllCommitedServiceState {
  final List<FetchAllBookedServiceModel> fetchAllCommitedServiceModel;
  const FetchAllCommitedServiceSuccessState({
    required this.fetchAllCommitedServiceModel,
  });
}

final class FetchAllCommitedServiceFailState
    extends FetchAllCommitedServiceState {}
