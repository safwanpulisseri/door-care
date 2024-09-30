import 'dart:developer';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repository/book_service_repo.dart';
part 'enter_details_event.dart';
part 'enter_details_state.dart';

class EnterDetailsBloc extends Bloc<EnterDetailsEvent, EnterDetailsState> {
  final BookServiceRepo _bookServiceRepo;
  EnterDetailsBloc(this._bookServiceRepo) : super(EnterDetailsInitialState()) {
    on<EnterServiceDetailsEvent>((event, emit) async {
      emit(EnterDetailsLoadingState());
      try {
        var response = await _bookServiceRepo.bookAnService(
          service: event.serviceName,
          serviceImg: event.serviceImg,
          firstHourCharge: event.firstHourCharge,
          laterHourCharge: event.laterHourCharge,
          description: event.comments,
          date: event.date,
          startTime: event.startTime,
          endTime: event.endTime,
          latitude: event.latitude,
          longitude: event.longitude,
        );
        if (response.statusCode == 200) {
          emit(EnterDetailsSuccessState());
        } else {
          emit(EnterDetailsFailState());
          log('Book a Service failed: ${response.statusCode}');
          throw Exception('Book a Service failed');
        }
      } catch (e) {
        log(e.toString());
        emit(EnterDetailsFailState());
      }
    });
  }
}
