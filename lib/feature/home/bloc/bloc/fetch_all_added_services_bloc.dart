import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/model/fetch_all_service_model.dart';
import '../../data/repository/fetch_all_services_repo.dart';
part 'fetch_all_added_services_event.dart';
part 'fetch_all_added_services_state.dart';

class FetchAllAddedServicesBloc
    extends Bloc<FetchAllAddedServicesEvent, FetchAllAddedServicesState> {
  final FetchAllServiceRepo _fetchAllServiceRepo;
  FetchAllAddedServicesBloc(this._fetchAllServiceRepo)
      : super(FetchAllAddedServicesInitialState()) {
    on<FetchAllServicesEvent>((event, emit) async {
      emit(FetchAllAddedServicesLoadingState());
      try {
        final List<FetchAllServiceModel> fetchAllServiceModel =
            await _fetchAllServiceRepo.fetchServicesDetails();
        emit(FetchAllAddedServicesSuccessState(
            fetchAllServiceModel: fetchAllServiceModel));
      } catch (e) {
        emit(FetchAllAddedServicesFailState());
      }
    });
  }
}
