import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:door_care/feature/auth/data/model/user_model.dart';
import 'package:door_care/feature/auth/data/service/local/auth_local_service.dart';
import '../service/remote/book_service_remote_service.dart';

class BookServiceRepo {
  final BookServiceRemoteService _bookServiceRemoteService;
  final AuthLocalService _authLocalService;

  BookServiceRepo(
    this._bookServiceRemoteService,
    this._authLocalService,
  );

  Future<Response<dynamic>> bookAnService({
    required String service,
    required String serviceImg,
    required num firstHourCharge,
    required num laterHourCharge,
    required String description,
    required String date,
    required String startTime,
    required String endTime,
    required num latitude,
    required num longitude,
  }) async {
    try {
      String? token = await _authLocalService.getToken();
      if (token == null) {
        throw Exception('No token Found');
      }
      // Fetch user details
      final UserModel? userModel = await _authLocalService.getUser();
      if (userModel == null) {
        throw Exception('No user found');
      }
      final userId = userModel.id;

      var response = await _bookServiceRemoteService.bookService(
        token: token,
        userId: userId,
        service: service,
        serviceImg: serviceImg,
        firstHourCharge: firstHourCharge,
        laterHourCharge: laterHourCharge,
        description: description,
        date: date,
        startTime: startTime,
        endTime: endTime,
        latitude: latitude,
        longitude: longitude,
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        log('Book a service failed with status code: ${response.statusCode}');
        throw Exception('Book service failed');
      }
    } catch (e) {
      log('Error during book a service: $e');
      throw Exception('Book a service failed');
    }
  }
}
