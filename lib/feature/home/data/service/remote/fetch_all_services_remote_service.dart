import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FetchAllServicesRemoteService {
  final String _link = dotenv.env['ADMIN_API_LINK']!;

  final Dio dio = Dio();

  Future<Response<dynamic>> fetchAllServiceDetails() async {
    log("on fetch all service in dio");
    try {
      var response = await dio.get(
        "${_link}getServices",
      );
      log("success");
      return response;
    } catch (e) {
      log("Error fetch all service: $e");
      throw Exception("Failed to fetch all service");
    }
  }
}
