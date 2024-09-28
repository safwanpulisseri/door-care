part of 'enter_details_bloc.dart';

sealed class EnterDetailsState extends Equatable {
  const EnterDetailsState();

  @override
  List<Object> get props => [];
}

final class EnterDetailsInitialState extends EnterDetailsState {}

final class EnterDetailsLoadingState extends EnterDetailsState {}

final class EnterDetailsSuccessState extends EnterDetailsState {}

final class EnterDetailsFailState extends EnterDetailsState {}
