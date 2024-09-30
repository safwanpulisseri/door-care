import 'dart:developer';
import 'package:door_care/feature/auth/data/service/local/auth_local_service.dart';
import '../service/remote/auth_remote_service.dart';
import '../model/user_model.dart';

class AuthRepo {
  final AuthRemoteService _authRemoteService;
  final AuthLocalService _authLocalService;

  AuthRepo(
    this._authRemoteService,
    this._authLocalService,
  );

  Future<UserModel?> getUser() async {
    final UserModel? userModel = await _authLocalService.getUser();
    if (userModel != null) {
      return userModel;
    } else {
      return null;
    }
  }

  Future<UserModel> emailSignIn({
    required String email,
    required String password,
  }) async {
    try {
      var response = await _authRemoteService.signIn(
        email: email,
        password: password,
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        final token = response.data['token'] as String;
        log("Token received: $token");

        final Map<String, dynamic> responseData =
            response.data['data'] as Map<String, dynamic>;
        final UserModel userModel = UserModel.fromMap(responseData);

        await _authLocalService.saveUser(userModel, token);
        return userModel;
      } else {
        log('Login failed with status code: ${response.statusCode}');
        throw Exception('Login failed');
      }
    } catch (e) {
      log('Error during login: $e');
      throw Exception('Login failed');
    }
  }

  Future<UserModel> userRegistration({
    required String name,
    required String mobile,
    required String email,
    required String password,
  }) async {
    try {
      var response = await _authRemoteService.signUp(
        name: name,
        mobile: mobile,
        email: email,
        password: password,
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        final token = response.data['token'] as String;
        log("Token received: $token");
        final Map<String, dynamic> responseData =
            response.data['user'] as Map<String, dynamic>;
        final UserModel userModel = UserModel.fromMap(responseData);
        await _authLocalService.saveUser(userModel, token);
        return userModel;
      } else {
        log('Registration failed with status code ${response.statusCode}');
        throw Exception('Registration failed');
      }
    } catch (e) {
      log('Error during registration: $e');
      throw Exception('Registration failed');
    }
  }

  Future<UserModel> googleAuth() async {
    try {
      var response = await _authRemoteService.googleAuth();
      if (response?.statusCode == 200) {
        log(response!.data.toString());
        final token = response.data['token'] as String;
        log("Token received: $token");
        final Map<String, dynamic> responseData =
            response.data['data'] as Map<String, dynamic>;
        final UserModel userModel = UserModel.fromMap(responseData);
        await _authLocalService.saveUser(userModel, token);
        return userModel;
      } else {
        log('Login failed${response?.statusCode}');
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<void> signOut() async {
    await _authLocalService.removeUser();
  }
}
