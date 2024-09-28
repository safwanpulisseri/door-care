// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

class FetchAllBookedServiceModel {
  String id;
  String userId;
  String? workerId;
  String serviceName;
  String serviceImg;
  num firstHourCharge;
  num laterHourCharge;
  DateTime date;
  String startTime;
  String endTime;
  String description;
  String status;
  num price;
  bool payment;
  String paymentId;
  double latitude;
  double longitude;
  DateTime createdAt;
  DateTime updatedAt;

  FetchAllBookedServiceModel({
    required this.id,
    required this.userId,
    this.workerId,
    required this.serviceName,
    required this.serviceImg,
    required this.firstHourCharge,
    required this.laterHourCharge,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.status,
    required this.price,
    required this.payment,
    required this.paymentId,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  FetchAllBookedServiceModel copyWith({
    String? id,
    String? userId,
    String? workerId,
    String? serviceName,
    String? serviceImg,
    num? firstHourCharge,
    num? laterHourCharge,
    DateTime? date,
    String? startTime,
    String? endTime,
    String? description,
    String? status,
    num? price,
    bool? payment,
    String? paymentId,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FetchAllBookedServiceModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      workerId: workerId ?? this.workerId,
      serviceName: serviceName ?? this.serviceName,
      serviceImg: serviceImg ?? this.serviceImg,
      firstHourCharge: firstHourCharge ?? this.firstHourCharge,
      laterHourCharge: laterHourCharge ?? this.laterHourCharge,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      description: description ?? this.description,
      status: status ?? this.status,
      price: price ?? this.price,
      payment: payment ?? this.payment,
      paymentId: paymentId ?? this.paymentId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'userId': userId,
      'workerId': workerId,
      'service': serviceName,
      'serviceImg': serviceImg,
      'firstHourCharge': firstHourCharge,
      'laterHourCharge': laterHourCharge,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'description': description,
      'status': status,
      'price': price,
      'payment': payment,
      'paymentId': paymentId,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory FetchAllBookedServiceModel.fromMap(Map<String, dynamic> map) {
    log(map.length.toString());
    map.forEach(
      (key, value) {
        log("key -> $key value -> $value");
      },
    );
    return FetchAllBookedServiceModel(
      id: map['_id'] as String,
      userId: map['userId'] as String,
      workerId: map['workerId'] as String?,
      serviceName: map['service'] as String,
      serviceImg: map['serviceImg'] as String,
      firstHourCharge: map['firstHourCharge'] as num,
      laterHourCharge: map['laterHourCharge'] as num,
      date: DateTime.parse(map['date'] as String),
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      price: map['price'] as num,
      payment: map['payment'] as bool,
      paymentId: map['paymentId'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchAllBookedServiceModel.fromJson(String source) =>
      FetchAllBookedServiceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FetchAllBookedServiceModel(id: $id, userId: $userId, workerId: $workerId, serviceName: $serviceName, serviceImg: $serviceImg, firstHourCharge: $firstHourCharge, laterHourCharge: $laterHourCharge, date: $date, startTime: $startTime, endTime: $endTime, description: $description, status: $status, price: $price, payment: $payment, paymentId: $paymentId, latitude: $latitude, longitude: $longitude, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant FetchAllBookedServiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.workerId == workerId &&
        other.serviceName == serviceName &&
        other.serviceImg == serviceImg &&
        other.firstHourCharge == firstHourCharge &&
        other.laterHourCharge == laterHourCharge &&
        other.date == date &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.description == description &&
        other.status == status &&
        other.price == price &&
        other.payment == payment &&
        other.paymentId == paymentId &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        workerId.hashCode ^
        serviceName.hashCode ^
        serviceImg.hashCode ^
        firstHourCharge.hashCode ^
        laterHourCharge.hashCode ^
        date.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        description.hashCode ^
        status.hashCode ^
        price.hashCode ^
        payment.hashCode ^
        paymentId.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
