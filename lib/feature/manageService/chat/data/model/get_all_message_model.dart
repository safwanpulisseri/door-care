import 'dart:convert';

class GetAllMessageModel {
  String id;
  String conversationId;
  String senderId;
  String receiverId;
  String text;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;

  GetAllMessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  GetAllMessageModel copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? receiverId,
    String? text,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GetAllMessageModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      text: text ?? this.text,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'conversationId': conversationId,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory GetAllMessageModel.fromMap(Map<String, dynamic> map) {
    return GetAllMessageModel(
      id: map['_id'] as String,
      conversationId: map['conversationId'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      text: map['text'] as String,
      status: map['status'] as bool,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllMessageModel.fromJson(String source) =>
      GetAllMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(id: $id, conversationId: $conversationId, senderId: $senderId, receiverId: $receiverId, text: $text, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant GetAllMessageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.conversationId == conversationId &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.text == text &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        conversationId.hashCode ^
        senderId.hashCode ^
        receiverId.hashCode ^
        text.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

// import 'dart:convert';

// class MessageModel {
//   String conversationId;
//   String senderId;
//   String receiverId;
//   String text;
//   bool status;
//   String id;
//   DateTime createdAt;
//   DateTime updatedAt;

//   MessageModel({
//     required this.conversationId,
//     required this.senderId,
//     required this.receiverId,
//     required this.text,
//     required this.status,
//     required this.id,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   MessageModel copyWith({
//     String? conversationId,
//     String? senderId,
//     String? receiverId,
//     String? text,
//     bool? status,
//     String? id,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) {
//     return MessageModel(
//       conversationId: conversationId ?? this.conversationId,
//       senderId: senderId ?? this.senderId,
//       receiverId: receiverId ?? this.receiverId,
//       text: text ?? this.text,
//       status: status ?? this.status,
//       id: id ?? this.id,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'conversationId': conversationId,
//       'senderId': senderId,
//       'receiverId': receiverId,
//       'text': text,
//       'status': status,
//       '_id': id,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }

//   factory MessageModel.fromMap(Map<String, dynamic> map) {
//     return MessageModel(
//       conversationId: map['conversationId'] as String,
//       senderId: map['senderId'] as String,
//       receiverId: map['receiverId'] as String,
//       text: map['text'] as String,
//       status: map['status'] as bool,
//       id: map['_id'] as String,
//       createdAt: DateTime.parse(map['createdAt'] as String),
//       updatedAt: DateTime.parse(map['updatedAt'] as String),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory MessageModel.fromJson(String source) =>
//       MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'ConversationModel(conversationId: $conversationId, senderId: $senderId, receiverId: $receiverId, text: $text, status: $status, id: $id, createdAt: $createdAt, updatedAt: $updatedAt)';
//   }

//   @override
//   bool operator ==(covariant MessageModel other) {
//     if (identical(this, other)) return true;

//     return other.conversationId == conversationId &&
//         other.senderId == senderId &&
//         other.receiverId == receiverId &&
//         other.text == text &&
//         other.status == status &&
//         other.id == id &&
//         other.createdAt == createdAt &&
//         other.updatedAt == updatedAt;
//   }

//   @override
//   int get hashCode {
//     return conversationId.hashCode ^
//         senderId.hashCode ^
//         receiverId.hashCode ^
//         text.hashCode ^
//         status.hashCode ^
//         id.hashCode ^
//         createdAt.hashCode ^
//         updatedAt.hashCode;
//   }
// }
