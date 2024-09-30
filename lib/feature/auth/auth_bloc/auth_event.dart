part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class CheckUserEvent extends AuthEvent {}

final class EmailSignInAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const EmailSignInAuthEvent({
    required this.email,
    required this.password,
  });
}

final class AccountCreateAuthEvent extends AuthEvent {
  final String name;
  final String mobile;
  final String email;
  final String password;

  const AccountCreateAuthEvent({
    required this.name,
    required this.mobile,
    required this.email,
    required this.password,
  });
}

final class AuthGoogleEvent extends AuthEvent {}

final class SignOutEvent extends AuthEvent {}
