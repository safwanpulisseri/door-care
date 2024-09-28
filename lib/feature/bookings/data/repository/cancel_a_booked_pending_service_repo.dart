import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../auth/data/service/local/auth_local_service.dart';
import '../service/remote/cancel_a_booked_pending_service.dart';

class CancelABookedPendingServiceRepo {
  final CancelABookedPendingService _cancelABookedPendingService;
  final AuthLocalService _authLocalService;

  CancelABookedPendingServiceRepo(
    this._cancelABookedPendingService,
    this._authLocalService,
  );

  Future<Response<dynamic>> cancelABookedPendingServices({
    required String bookingId,
  }) async {
    try {
      String? token = await _authLocalService.getToken();
      if (token == null) {
        throw Exception('No token Found');
      }

      var response =
          await _cancelABookedPendingService.cancelBookedPendingService(
        token: token,
        bookingId: bookingId,
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        log('cancel a booked Service failed with status code: ${response.statusCode}');
        throw Exception('cancel a booked Service failed');
      }
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
