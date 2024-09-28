import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final String chatApiLink = dotenv.env['CHAT_API_LINK']!;

Future<List<dynamic>> getMessages(String conversationId) async {
  final response = await http.get(
    Uri.parse('$chatApiLink/api/chat/message?conversationId=$conversationId'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    return json.decode(response.body)['message']['data'];
  } else {
    throw Exception('Failed to load messages');
  }
}
