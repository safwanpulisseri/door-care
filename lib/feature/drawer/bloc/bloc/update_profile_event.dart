part of 'update_profile_bloc.dart';

sealed class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

final class UpdateUserProfileImageEvent extends UpdateProfileEvent {
  final String profileImg;
  const UpdateUserProfileImageEvent({
    required this.profileImg,
  });
}

final class UpdateUserProfileDetailsEvent extends UpdateProfileEvent {
  final String name;
  final String mobile;
  const UpdateUserProfileDetailsEvent({
    required this.name,
    required this.mobile,
  });
}
