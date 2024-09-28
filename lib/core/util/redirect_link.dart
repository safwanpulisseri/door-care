import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

final class RedirectLink {
  RedirectLink._();

  static Future<void> launchPrivacyPolicy() async {
    final Uri url = Uri.parse(
        'https://www.termsfeed.com/live/0fe24462-d978-4540-978f-3dc9513a2be4');

    try {
      await launchUrl(url);
    } catch (e) {
      if (kDebugMode) {
        print('Error launching URL: $e');
      }
      // Handle the error as needed
    }
  }

  // Function to launch YouTube video
  static Future<void> launchYouTubeVideo() async {
    final Uri url = Uri.parse('https://youtu.be/QJ0k49VmdMc');

    try {
      await launchUrl(url);
    } catch (e) {
      if (kDebugMode) {
        print('Error launching URL: $e');
      }
      // Handle the error as needed
    }
  }

  // Function to launch email on tap
  static Future<void> launchEmail() async {
    const String emailAddress = 'safwanpulisseri123@gmail.com';
    const String emailSubject = 'Feedback/Question';
    const String emailBody = 'Your_feedback/question_type_here';

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': emailSubject,
        'body': emailBody,
      },
    );
    try {
      await launchUrl(emailUri);
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print('Error launching URL: $e');
      }
    }
  }
}
