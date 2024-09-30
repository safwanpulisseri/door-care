// ignore_for_file: file_names
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../auth/data/model/user_model.dart';
import '../../../../auth/data/service/local/auth_local_service.dart';
import '../model/conversation_model.dart';
import '../model/get_all_message_model.dart';
import '../service/remote/createConversationRemote.dart';

class Createconversationrepo {
  final Createconversation _createconversation;
  final AuthLocalService _authLocalService;

  Createconversationrepo(
    this._createconversation,
    this._authLocalService,
  );

  Future<ConversationModel> createConversationWithUser({
    required String receiverId,
  }) async {
    try {
      UserModel? userModel = await _authLocalService.getUser();
      if (userModel == null) {
        throw Exception('No UserModel Found');
      }
      String workerId = userModel.id;

      var response = await _createconversation.createConversation(
        senderId: workerId,
        receiverId: receiverId,
      );

      log('API Response: ${response.data}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            response.data['newConversation']['data'] as Map<String, dynamic>;
        log('Parsed Response Data: $responseData');
        final ConversationModel conversationModel =
            ConversationModel.fromMap(responseData);

        log('Conversation Model: ${conversationModel.toString()}');
        return conversationModel;
      } else {
        log('create Chat failed: ${response.statusCode}');
        throw Exception('Failed to create chat');
      }
    } catch (e) {
      log('Error creating conversation: ${e.toString()}');
      throw Exception('Error creating conversation');
    }
  }

  Future<Response<dynamic>> createMessageWithUser({
    required String conversationId,
    required String receiverId,
    required String text,
  }) async {
    try {
      UserModel? userModel = await _authLocalService.getUser();
      if (userModel == null) {
        throw Exception('No UserModel Found');
      }
      String workerId = userModel.id;

      var response = await _createconversation.createMessage(
        conversationId: conversationId,
        senderId: workerId,
        receiverId: receiverId,
        text: text,
      );

      log('API Response: ${response.data}');

      if (response.statusCode == 200) {
        return response;
      } else {
        log('createMessageWithUser failed: ${response.statusCode}');
        throw Exception('Failed to create chat');
      }
    } catch (e) {
      log('Error createMessageWithUser: ${e.toString()}');
      throw Exception('Error createMessageWithUser');
    }
  }

  Future<List<GetAllMessageModel>> getAllMessage({
    required String conversationId,
  }) async {
    try {
      var response = await _createconversation.getMessage(
        conversationId: conversationId,
      );

      log('API Response: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            response.data['message']['data'] as List<dynamic>;
        log('Parsed Response Data: $responseData');

        // Convert the list of data to a list of MessageModel objects
        final List<GetAllMessageModel> messages = responseData
            .map((data) =>
                GetAllMessageModel.fromMap(data as Map<String, dynamic>))
            .toList();

        log('Messages: ${messages.toString()}');
        return messages;
      } else {
        log('Fetch messages failed: ${response.statusCode}');
        throw Exception('Failed to fetch messages');
      }
    } catch (e) {
      log('Error fetching messages: ${e.toString()}');
      throw Exception('Error fetching messages');
    }
  }
}
