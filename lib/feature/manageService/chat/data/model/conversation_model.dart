import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';

class ConversationModel {
  String id;
  List<String> members;
  String user;
  String userEmail;
  String userProfile;
  String worker;
  String workerProfile;

  ConversationModel({
    required this.id,
    required this.members,
    required this.user,
    required this.userEmail,
    required this.userProfile,
    required this.worker,
    required this.workerProfile,
  });

  ConversationModel copyWith({
    String? id,
    List<String>? members,
    String? user,
    String? userEmail,
    String? userProfile,
    String? worker,
    String? workerProfile,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      members: members ?? this.members,
      user: user ?? this.user,
      userEmail: userEmail ?? this.userEmail,
      userProfile: userProfile ?? this.userProfile,
      worker: worker ?? this.worker,
      workerProfile: workerProfile ?? this.workerProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'members': members,
      'user': user,
      'userEmail': userEmail,
      'user_profile': userProfile,
      'worker': worker,
      'worker_profile': workerProfile,
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    log(map.length.toString());
    map.forEach(
      (key, value) {
        log("key -> $key value -> $value");
      },
    );
    return ConversationModel(
      id: map['_id'] as String? ?? '', // Handle potential null values
      members: List<String>.from(map['members'] as List? ?? []),
      user: map['user'] as String? ?? '',
      userEmail: map['userEmail'] as String? ?? '',
      userProfile: map['user_profile'] as String? ?? '',
      worker: map['worker'] as String? ?? '',
      workerProfile: map['worker_profile'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationModel.fromJson(String source) =>
      ConversationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ConversationModel(id: $id, members: $members, user: $user, userEmail: $userEmail, userProfile: $userProfile, worker: $worker, workerProfile: $workerProfile)';
  }

  @override
  bool operator ==(covariant ConversationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.members, members) &&
        other.user == user &&
        other.userEmail == userEmail &&
        other.userProfile == userProfile &&
        other.worker == worker &&
        other.workerProfile == workerProfile;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        members.hashCode ^
        user.hashCode ^
        userEmail.hashCode ^
        userProfile.hashCode ^
        worker.hashCode ^
        workerProfile.hashCode;
  }
}
