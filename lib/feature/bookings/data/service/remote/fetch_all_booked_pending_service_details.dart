import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FetchAllBookedServiceDetails {
  final String _link = dotenv.env['MAIN_API_LINK']!;

  final Dio dio = Dio();
  Future<Response<dynamic>> fetchAllServiceDetails({
    required String token,
    required userId,
  }) async {
    log("on fetch all service in dio");
    try {
      var response = await dio.get(
        "${_link}getBookings",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'userId': userId,
          'status': 'pending',
          'workerId': null,
          'service': null,
        },
      );
      log("success");
      log("Response data: ${response.data}");
      return response;
    } catch (e) {
      if (e is DioException) {
        log("Error response data: ${e.response?.data}");
        log("Error response headers: ${e.response?.headers}");
        log("Error response status code: ${e.response?.statusCode}");
      }
      log("Error fetch all booked service: $e");
      throw Exception("Failed to fetch all booked service");
    }
  }
}
