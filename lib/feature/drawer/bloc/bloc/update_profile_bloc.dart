import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../auth/data/model/user_model.dart';
import '../../data/repository/update_profile_repo.dart';
part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileRepo _updateProfileRepo;
  UpdateProfileBloc(this._updateProfileRepo)
      : super(UpdateProfileInitialState()) {
    on<UpdateUserProfileImageEvent>((event, emit) async {
      emit(UpdateProfileLoadingState());
      try {
        final UserModel userModel = await _updateProfileRepo.addProfileImage(
          profileImg: event.profileImg,
        );

        emit(UpdateProfileSuccessState(userModel: userModel));
      } catch (e) {
        emit(UpdateProfileFailState());
      }
    });
    on<UpdateUserProfileDetailsEvent>((event, emit) async {
      emit(UpdateProfileLoadingState());
      try {
        final UserModel userModel = await _updateProfileRepo.updateUserDetails(
          name: event.name,
          mobile: event.mobile,
        );

        emit(UpdateProfileSuccessState(userModel: userModel));
      } catch (e) {
        emit(UpdateProfileFailState());
      }
    });
  }
}
