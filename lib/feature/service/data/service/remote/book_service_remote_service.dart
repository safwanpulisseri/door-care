import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BookServiceRemoteService {
  final String _link = dotenv.env['MAIN_API_LINK']!;
  final dio = Dio();

  //User's book a service
  Future<Response<dynamic>> bookService({
    required String token,
    required String userId,
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
    log("on book a service in dio");
    try {
      var response = await dio.post(
        "${_link}bookService",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'userId': userId,
          'service': service,
          'serviceImg': serviceImg,
          'firstHourCharge': firstHourCharge,
          'laterHourCharge': laterHourCharge,
          'description': description,
          'date': date,
          'startTime': startTime,
          'endTime': endTime,
          'latitude': latitude,
          'longitude': longitude,
        },
      );
      log("success");
      return response;
    } catch (e) {
      log('Error during book a service $e');
      throw Exception();
    }
  }
}
