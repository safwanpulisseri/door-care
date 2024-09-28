part of 'fetch_all_commited_service_bloc.dart';

sealed class FetchAllCommitedServiceEvent extends Equatable {
  const FetchAllCommitedServiceEvent();

  @override
  List<Object> get props => [];
}

final class FetchCommitedServicesEvent extends FetchAllCommitedServiceEvent {}
