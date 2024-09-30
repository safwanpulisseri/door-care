part of 'fetch_all_added_services_bloc.dart';

sealed class FetchAllAddedServicesState extends Equatable {
  const FetchAllAddedServicesState();

  @override
  List<Object> get props => [];
}

final class FetchAllAddedServicesInitialState
    extends FetchAllAddedServicesState {}

final class FetchAllAddedServicesLoadingState
    extends FetchAllAddedServicesState {}

final class FetchAllAddedServicesSuccessState
    extends FetchAllAddedServicesState {
  final List<FetchAllServiceModel> fetchAllServiceModel;
  const FetchAllAddedServicesSuccessState({
    required this.fetchAllServiceModel,
  });
}

final class FetchAllAddedServicesFailState extends FetchAllAddedServicesState {}
