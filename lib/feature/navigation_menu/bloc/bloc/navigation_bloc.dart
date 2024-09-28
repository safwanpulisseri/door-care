import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<PageChangedEvent>((event, emit) {
      emit(NavigationPageState(event.pageIndex));
    });
  }
}
