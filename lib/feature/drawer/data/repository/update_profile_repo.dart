import 'dart:developer';
import 'package:door_care/feature/auth/data/service/local/auth_local_service.dart';
import '../../../auth/data/model/user_model.dart';
import '../service/remote/update_profile_remote.dart';

class UpdateProfileRepo {
  final UpdateProfileRemote _updateProfileRemote;
  final AuthLocalService _authLocalService;

  UpdateProfileRepo(
    this._updateProfileRemote,
    this._authLocalService,
  );

  Future<UserModel> addProfileImage({
    required String profileImg,
  }) async {
    try {
      String? token = await _authLocalService.getToken();
      if (token == null) {
        throw Exception('No token Found');
      }
      UserModel? userModel = await _authLocalService.getUser();
      if (userModel == null) {
        throw Exception('No UserModel Found');
      }
      String userId = userModel.id;

      var response = await _updateProfileRemote.addProfile(
        token: token,
        id: userId,
        profileImg: profileImg,
      );

      log('Full response: ${response.data.toString()}');

      if (response.statusCode == 200) {
        final responseData = response.data['user'];
        if (responseData != null && responseData is Map<String, dynamic>) {
          final UserModel userModel = UserModel.fromMap(responseData);

          return userModel;
        } else {
          log('Response user data is null or not in expected format: ${response.data}');
          throw Exception('Unexpected response format');
        }
      } else {
        log('addProfileImage failed with status code: ${response.statusCode}');
        throw Exception('addProfileImage failed');
      }
    } catch (e) {
      log('Error during addProfileImage: $e');
      throw Exception('addProfileImage failed');
    }
  }

  Future<UserModel> updateUserDetails({
    required String name,
    required String mobile,
  }) async {
    try {
      String? token = await _authLocalService.getToken();
      if (token == null) {
        throw Exception('No token Found');
      }
      UserModel? userModel = await _authLocalService.getUser();
      if (userModel == null) {
        throw Exception('No UserModel Found');
      }
      String userId = userModel.id;

      var response = await _updateProfileRemote.updateDetails(
        token: token,
        id: userId,
        name: name,
        mobile: mobile,
      );

      if (response.statusCode == 200) {
        // log(response.data.toString());
        // final token = response.data['token'] as String;
        // log("Token received: $token");
        final Map<String, dynamic> responseData =
            response.data['user'] as Map<String, dynamic>;
        final UserModel userModel = UserModel.fromMap(responseData);
        // await _authLocalService.saveUser(userModel, token);
        return userModel;
      } else {
        log('updateUserDetails failed with status code ${response.statusCode}');
        throw Exception('updateUserDetails failed');
      }
    } catch (e) {
      log('Error during updateUserDetails: $e');
      throw Exception('updateUserDetails failed');
    }
  }
}
