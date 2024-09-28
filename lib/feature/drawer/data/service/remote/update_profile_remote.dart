import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UpdateProfileRemote {
  final String _link = dotenv.env['MAIN_API_LINK']!;
  final dio = Dio();

  //Add/Update Profile Photo
  Future<Response<dynamic>> addProfile({
    required String token,
    required String id,
    required String profileImg,
  }) async {
    log("on dio");
    try {
      var response = await dio.patch("${_link}addProfile",
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            '_id': id,
            'profile_img': profileImg,
          });
      log("success");
      return response;
    } catch (e) {
      log('Error during addProfile $e');
      throw Exception();
    }
  }

  //Update name and moile number
  Future<Response<dynamic>> updateDetails({
    required String token,
    required String id,
    required String name,
    required String mobile,
  }) async {
    log("signup in dio");
    try {
      var response = await dio.patch("${_link}updateProfile",
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            '_id': id,
            'name': name,
            'mobile': mobile,
          });
      return response;
    } catch (e) {
      log('Error during updateDetails$e');
      throw Exception();
    }
  }
}
