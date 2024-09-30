part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final UserModel userModel;

  const AuthSuccessState({required this.userModel});
}

final class AuthFailState extends AuthState {}

final class AuthSignedOutState extends AuthState {}
