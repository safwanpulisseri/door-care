import 'dart:developer';
import 'package:dio/dio.dart';

class Createconversation {
  final String _link = "http://10.0.2.2:3000/api/chat/";
  final Dio dio = Dio();

  Future<Response<dynamic>> createConversation({
    required String senderId,
    required String receiverId,
  }) async {
    log("on dio");
    try {
      var response = await dio.post("${_link}conversation", data: {
        'senderId': senderId,
        'receiverId': receiverId,
      });
      log("success");
      return response;
    } catch (e) {
      log('Error during createConversation $e');
      throw Exception();
    }
  }

  Future<Response<dynamic>> createMessage({
    required String conversationId,
    required String senderId,
    required String receiverId,
    required String text,
  }) async {
    log("on dio");
    try {
      var response = await dio.post("${_link}message", data: {
        'conversationId': conversationId,
        'senderId': senderId,
        'receiverId': receiverId,
        'text': text,
      });
      log("success");
      return response;
    } catch (e) {
      log('Error during createMessage $e');
      throw Exception();
    }
  }

  Future<Response<dynamic>> getMessage({
    required String conversationId,
  }) async {
    log("on dio");
    try {
      var response = await dio.get(
        "${_link}message",
        // data: {
        //   'conversationId': conversationId,
        // },
        queryParameters: {
          'conversationId': conversationId,
        },
      );
      log("success");
      return response;
    } catch (e) {
      log('Error during getAllMessage $e');
      throw Exception();
    }
  }
}
