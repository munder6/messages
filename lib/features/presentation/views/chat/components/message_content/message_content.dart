import 'package:flutter/material.dart';

import '../../../../../../core/enums/messge_type.dart';
import '../../../../../domain/entities/message.dart';
import 'audio_player_widget.dart';
import 'image_widget.dart';
import 'text_widget.dart';
import 'video_palyer_widget.dart';

class MessageContent extends StatelessWidget {
  final Message message;
  final bool isMe;
  final bool isLast;

  const MessageContent({
    super.key,
    required this.message,
    required this.isMe,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    switch (message.messageType) {
      case MessageType.text:
        return TextWidget(message: message, isMe: isMe, isLast : isLast);
      case MessageType.image:
        return ImageWidget(message: message, isMe: isMe);
      case MessageType.video:
        return VideoPlayerItem(message: message, isMe: isMe);
      case MessageType.audio:
        return SizedBox(
            width: 240,
            child: AudioPlayerWidget(message: message, isMe: isMe));
      default:
        return TextWidget(message: message, isMe: isMe, isLast: isLast,);
    }
  }
}