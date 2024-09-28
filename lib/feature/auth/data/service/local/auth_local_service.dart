import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../model/user_model.dart';

final class AuthLocalService {
  static const String _storageKey = 'user_data_and_token';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Save user data and token
  Future<void> saveUser(UserModel user, String token) async {
    final Map<String, dynamic> userData = {
      'user': user.toJson(),
      'token': token,
    };
    final String userDataJson = jsonEncode(userData);
    await _secureStorage.write(key: _storageKey, value: userDataJson);
  }

  // Remove user data and token
  Future<void> removeUser() async {
    await _secureStorage.delete(key: _storageKey);
  }

  // Check if user is logged in
  Future<bool> isUserLoggedIn() async {
    final String? userDataJson = await _secureStorage.read(key: _storageKey);
    return userDataJson != null;
  }

  // Get stored user data
  Future<UserModel?> getUser() async {
    final String? userDataJson = await _secureStorage.read(key: _storageKey);
    if (userDataJson != null) {
      final Map<String, dynamic> userData = jsonDecode(userDataJson);
      final String userJson = userData['user'];
      return UserModel.fromJson(userJson);
    }
    return null;
  }

  // Get stored token
  Future<String?> getToken() async {
    final String? userDataJson = await _secureStorage.read(key: _storageKey);
    if (userDataJson != null) {
      final Map<String, dynamic> userData = jsonDecode(userDataJson);
      return userData['token'];
    }
    return null;
  }
}
