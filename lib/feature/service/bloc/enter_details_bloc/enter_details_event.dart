part of 'enter_details_bloc.dart';

sealed class EnterDetailsEvent extends Equatable {
  const EnterDetailsEvent();

  @override
  List<Object> get props => [];
}

final class EnterServiceDetailsEvent extends EnterDetailsEvent {
  final String serviceName;
  final String serviceImg;
  final num firstHourCharge;
  final num laterHourCharge;
  final String comments;
  final String date;
  final String startTime;
  final String endTime;
  final num latitude;
  final num longitude;

  const EnterServiceDetailsEvent({
    required this.serviceName,
    required this.serviceImg,
    required this.firstHourCharge,
    required this.laterHourCharge,
    required this.comments,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.latitude,
    required this.longitude,
  });
}
