part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class PageChangedEvent extends NavigationEvent {
  final int pageIndex;
  const PageChangedEvent(this.pageIndex);
  @override
  List<Object> get props => [pageIndex];
}
