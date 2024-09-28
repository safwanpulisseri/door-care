import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/png_asset.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.background,
        // elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.arrowLeft),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CircleAvatar(
              backgroundColor: AppColor.toneThree,
              backgroundImage: AssetImage(
                AppPngPath.personImage,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jhon Abraham',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColor.secondary,
                  ),
                ),
                Text('Active now',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColor.toneEight,
                    )),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildChatBubble(
                  context,
                  message: 'Hello! Jhon abraham',
                  timestamp: '09:25 AM',
                  isMe: true,
                ),
                _buildChatBubble(
                  context,
                  name: 'Safwan Pulisseri',
                  message: 'Hello ! Nazrul How are you?',
                  timestamp: '09:25 AM',
                  avatar: AppPngPath.homeCleanOne, // Add an image to the assets
                ),
                _buildChatBubble(
                  context,
                  message: 'You did your job well!',
                  timestamp: '09:25 AM',
                  isMe: true,
                ),
                _buildChatBubble(
                  context,
                  name: 'Safwan Pulisseri',
                  message: 'Have a great working week!!',
                  timestamp: '09:25 AM',
                  avatar: AppPngPath.homeCleanOne, // Add an image to the assets
                ),
                _buildChatBubble(
                  context,
                  message: 'Hope you like it',
                  timestamp: '09:25 AM',
                  isMe: true,
                ),
              ],
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(BuildContext context,
      {String? name,
      required String message,
      required String timestamp,
      bool isMe = false,
      String? avatar}) {
    final alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bgColor = isMe ? AppColor.primary : AppColor.toneTwelve;
    final textColor = isMe ? AppColor.background : AppColor.secondary;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        if (!isMe)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(avatar!),
                ),
                SizedBox(width: 10),
                Text(name!,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: alignment,
            children: [
              Text(message,
                  style: GoogleFonts.poppins(color: textColor, fontSize: 14)),
              SizedBox(height: 5),
              Text(timestamp,
                  style: GoogleFonts.poppins(
                      color: textColor.withOpacity(0.6), fontSize: 10)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageComposer() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
                //  controller: widget.controller,
                // validator: widget.validator,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.textfield,
                  hintText: 'Write your message',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: AppColor.primary,
                      width: 1.0,
                    ),
                  ),
                ),
                style: GoogleFonts.poppins(
                  color: AppColor.secondary,
                  fontSize: 16.0,
                )),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              //
            },
            child: Material(
              shape: const CircleBorder(),
              color: AppColor.primary,
              child: IconButton(
                icon: const Icon(
                  IconlyLight.send,
                  color: AppColor.background,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
