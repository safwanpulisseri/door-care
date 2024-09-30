// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/model/fetch_all_booked_service_model.dart';
import '../../data/repository/fetch_all_booked_pending_service_repo.dart';
part 'fetch_all_pending_services_event.dart';
part 'fetch_all_pending_services_state.dart';

class FetchAllPendingServicesBloc
    extends Bloc<FetchAllPendingServicesEvent, FetchAllPendingServicesState> {
  final FetchAllBookedServiceRepo _fetchAllBookedServiceRepo;
  FetchAllPendingServicesBloc(this._fetchAllBookedServiceRepo)
      : super(FetchAllPendingServicesInitialState()) {
    on<FetchAllBookedPendingServicesEvent>((event, emit) async {
      emit(FetchAllPendingServicesLoadingState());
      try {
        final List<FetchAllBookedServiceModel>
            fetchAllBookedPendingServiceModel =
            await _fetchAllBookedServiceRepo.fetchServicesDetails();
        emit(FetchAllPendingServicesSuccessState(
            fetchAllBookedServiceModel: fetchAllBookedPendingServiceModel));
      } catch (e) {
        emit(FetchAllPendingServicesFailState());
      }
    });
  }
}
