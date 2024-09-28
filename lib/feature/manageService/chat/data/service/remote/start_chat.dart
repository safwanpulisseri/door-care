import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String chatApiLink = dotenv.env['CHAT_API_LINK']!;

Future<Map<String, dynamic>> startConversation(
    String senderId, String receiverId) async {
  final response = await http.post(
    Uri.parse('$chatApiLink/api/chat/conversation'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'senderId': senderId,
      'receiverId': receiverId,
    }),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    final conversationId = data['newConversation']['data']['_id'];
    final workername = data['newConversation']['data']['worker'];
    final workerProfile = data['newConversation']['data']['worker_profile'];

    log('Conversation ID: $conversationId');
    log('Sender ID: $senderId');
    log('Receiver ID: $receiverId');
    log('workername: $workername');
    log('workerProfile: $workerProfile');

    return {
      'conversationId': conversationId,
      'workername': workername,
      'workerProfile': workerProfile,
    };
  } else {
    throw Exception('Failed to create conversation');
  }
}
