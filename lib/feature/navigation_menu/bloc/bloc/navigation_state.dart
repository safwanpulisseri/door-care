part of 'navigation_bloc.dart';

sealed class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

final class NavigationInitial extends NavigationState {}

final class NavigationPageState extends NavigationState {
  final int pageIndex;
  const NavigationPageState(this.pageIndex);
  @override
  List<Object> get props => [pageIndex];
}
