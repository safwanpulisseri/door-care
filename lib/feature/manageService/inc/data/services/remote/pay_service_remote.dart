import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PayServiceRemote {
  final String _link = dotenv.env['MAIN_API_LINK']!;

  final dio = Dio();

  Future<String?> createPaymentSession({
    required num amount,
    required String bookingId,
    required String workerId,
  }) async {
    try {
      var response = await dio.post(
        "${_link}payment",
        data: {
          'amount': amount,
          'bookingId': bookingId,
          'workerId': workerId,
        },
      );

      log('Response status: ${response.statusCode}');
      log('Response data: ${response.data}');

      if (response.statusCode == 200) {
        return response.data['data']; // Access the sessionId correctly
      } else {
        log('Error: Failed to create session, backend returned ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error during createPaymentSession: $e');
    }
    return null;
  }
}
