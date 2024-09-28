part of 'fetch_all_added_services_bloc.dart';

sealed class FetchAllAddedServicesEvent extends Equatable {
  const FetchAllAddedServicesEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllServicesEvent extends FetchAllAddedServicesEvent {}
