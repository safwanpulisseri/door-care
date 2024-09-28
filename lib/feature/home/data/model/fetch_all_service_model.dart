// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

class FetchAllServiceModel {
  String id;
  String serviceName;
  String description;
  num firstHourCharge;
  num laterHourCharge;
  String serviceImg;
  DateTime createdAt;
  bool isBlocked;

  FetchAllServiceModel({
    required this.id,
    required this.serviceName,
    required this.description,
    required this.firstHourCharge,
    required this.laterHourCharge,
    required this.serviceImg,
    required this.createdAt,
    required this.isBlocked,
  });

  FetchAllServiceModel copyWith({
    String? id,
    String? serviceName,
    String? description,
    num? firstHourCharge,
    num? laterHourCharge,
    String? serviceImg,
    DateTime? createdAt,
    bool? isBlocked,
  }) {
    return FetchAllServiceModel(
      id: id ?? this.id,
      serviceName: serviceName ?? this.serviceName,
      description: description ?? this.description,
      firstHourCharge: firstHourCharge ?? this.firstHourCharge,
      laterHourCharge: laterHourCharge ?? this.laterHourCharge,
      serviceImg: serviceImg ?? this.serviceImg,
      createdAt: createdAt ?? this.createdAt,
      isBlocked: isBlocked ?? this.isBlocked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'serviceName': serviceName,
      'description': description,
      'firstHourCharge': firstHourCharge,
      'laterHourCharge': laterHourCharge,
      'service_img': serviceImg,
      'createdAt': createdAt.toIso8601String,
      'isBlocked': isBlocked,
    };
  }

  factory FetchAllServiceModel.fromMap(Map<String, dynamic> map) {
    log(map.length.toString());
    map.forEach(
      (key, value) {
        log("key -> $key value -> $value");
      },
    );
    return FetchAllServiceModel(
      id: map['_id'] as String,
      serviceName: map['serviceName'] as String,
      description: map['description'] as String,
      firstHourCharge: map['firstHourCharge'] as num,
      laterHourCharge: map['laterHourCharge'] as num,
      serviceImg: map['service_img'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      isBlocked: map['isBlocked'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchAllServiceModel.fromJson(String source) =>
      FetchAllServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FetchAllServiceModel(id: $id, serviceName: $serviceName, description: $description, firstHourCharge: $firstHourCharge, laterHourCharge: $laterHourCharge, serviceImg: $serviceImg, createdAt: $createdAt, isBlocked: $isBlocked)';
  }

  @override
  bool operator ==(covariant FetchAllServiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.serviceName == serviceName &&
        other.description == description &&
        other.firstHourCharge == firstHourCharge &&
        other.laterHourCharge == laterHourCharge &&
        other.serviceImg == serviceImg &&
        other.createdAt == createdAt &&
        other.isBlocked == isBlocked;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        serviceName.hashCode ^
        description.hashCode ^
        firstHourCharge.hashCode ^
        laterHourCharge.hashCode ^
        serviceImg.hashCode ^
        createdAt.hashCode ^
        isBlocked.hashCode;
  }
}
