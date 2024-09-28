import 'dart:convert';
import 'dart:developer';

class UserModel {
  String id;
  String name;
  String email;
  String mobile;
  String profileImg;
  bool isBlocked;
  String password;
  // String token;
  DateTime createdAt;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.profileImg,
    required this.isBlocked,
    required this.password,
    //required this.token,
    required this.createdAt,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? mobile,
    String? profileImg,
    bool? isBlocked,
    String? password,
    String? token,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      profileImg: profileImg ?? this.profileImg,
      isBlocked: isBlocked ?? this.isBlocked,
      password: password ?? this.password,
      // token: token ?? this.token,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'profile_img': profileImg,
      'isBlocked': isBlocked,
      'password': password,
      // 'token': token,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    log(map.length.toString());
    map.forEach(
      (key, value) {
        log("key -> $key value -> $value");
      },
    );
    return UserModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] as String,
      profileImg: map['profile_img'] as String,
      isBlocked: map['isBlocked'] as bool,
      password: map['password'] as String,
      // token: map['token'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, mobile: $mobile, profileImg: $profileImg, isBlocked: $isBlocked, password: $password,createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.mobile == mobile &&
        other.profileImg == profileImg &&
        other.isBlocked == isBlocked &&
        other.password == password &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        mobile.hashCode ^
        profileImg.hashCode ^
        isBlocked.hashCode ^
        password.hashCode ^
        createdAt.hashCode;
  }
}
