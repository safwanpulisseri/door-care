import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/model/fetch_all_booked_service_model.dart';
import '../../data/repository/fetch_all_committed_service_repo.dart';
part 'fetch_all_commited_service_event.dart';
part 'fetch_all_commited_service_state.dart';

class FetchAllCommitedServiceBloc
    extends Bloc<FetchAllCommitedServiceEvent, FetchAllCommitedServiceState> {
  final FetchAllCommitedServiceRepo _fetchAllCommitedServiceRepo;
  FetchAllCommitedServiceBloc(this._fetchAllCommitedServiceRepo)
      : super(FetchAllCommitedServiceInitialState()) {
    on<FetchCommitedServicesEvent>((event, emit) async {
      emit(FetchAllCommitedServiceLoadingState());
      try {
        final List<FetchAllBookedServiceModel>
            fetchAllBookedPendingServiceModel =
            await _fetchAllCommitedServiceRepo.fetchAllCommitedServiceDetails();
        emit(FetchAllCommitedServiceSuccessState(
            fetchAllCommitedServiceModel: fetchAllBookedPendingServiceModel));
      } catch (e) {
        emit(FetchAllCommitedServiceFailState());
      }
    });
  }
}
