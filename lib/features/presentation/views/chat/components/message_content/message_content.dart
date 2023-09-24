import 'package:flutter/material.dart';

import '../../../../../../core/enums/messge_type.dart';
import '../../../../../domain/entities/message.dart';
import 'audio_player_widget.dart';
import 'image_widget.dart';
import 'text_widget.dart';
import 'video_palyer_widget.dart';

class MessageContent extends StatefulWidget {
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
  State<MessageContent> createState() => _MessageContentState();

}

class _MessageContentState extends State<MessageContent> {

  @override
  Widget build(BuildContext context) {
    switch (widget.message.messageType) {
      case MessageType.text:
        return TextWidget(message: widget.message, isMe: widget.isMe, isLast : widget.isLast);
      case MessageType.image:
        return ImageWidget(message: widget.message, isMe: widget.isMe);
      case MessageType.video:
        return VideoPlayerItem(message: widget.message, isMe: widget.isMe);
      case MessageType.audio:
        return SizedBox(
            width: 240,
            child: AudioPlayerWidget(message: widget.message, isMe: widget.isMe));
      default:
        return TextWidget(message: widget.message, isMe: widget.isMe, isLast: widget.isLast,);
    }
  }
}