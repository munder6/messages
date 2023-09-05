import 'package:flutter/material.dart';
import 'package:message_me_app/core/utils/routes/routes_manager.dart';
import '../../../../core/utils/thems/my_colors.dart';
import 'components/bottom_field/bottom_chat_with_icon.dart';
import 'components/chat_appbar.dart';
import 'components/message/messages_list.dart';
import 'components/bottom_field/recording_mic.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String uId;

  const ChatScreen({Key? key, required this.name, required this.uId})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    AppRoutes.isChatScreenActive = true;
  }

  @override
  void dispose() {
    AppRoutes.isChatScreenActive = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorss.primaryColor,
      appBar: ChatAppBar(name: widget.name, receiverId: widget.uId),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MessagesList(receiverId: widget.uId),
              // Divider(
              //   color: AppColorss.dividersColor.withOpacity(0.3),
              //   height: 0.3,
              // ),
              BottomChatWithIcon(receiverId: widget.uId),
            ],
          ),
          RecordingMic(receiverId: widget.uId),
        ],
      ),
    );
  }
}
