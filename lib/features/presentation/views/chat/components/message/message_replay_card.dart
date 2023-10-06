import 'package:flutter/material.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';

import '../../../../../../core/enums/messge_type.dart';
import '../../../../../domain/entities/message.dart';
import '../../../../controllers/chat_cubit/chat_cubit.dart';

class ReplayMessageCard extends StatelessWidget {
  final bool showCloseButton;
  final MessageType repliedMessageType;

  final String text;
  final bool isMe;
  final String repliedTo;

  //final MessageReplay messageReplay;

  const ReplayMessageCard({
    super.key,
    this.showCloseButton = false,
    required this.repliedMessageType,
    required this.text,
    required this.isMe, required this.repliedTo,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
          top: 10,
          bottom: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: isMe ? AppColorss.myMessageReplyColor.withOpacity(0.35) : AppColorss.senderMessageReplyColor.withOpacity(0.1)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ReplayMessageContent(
                repliedMessageType: repliedMessageType,
                text: text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReplayMessageCardForSender extends StatelessWidget {
  final bool showCloseButton;
  final MessageType repliedMessageType;
  final String text;
  final bool isMe;
  final String repliedTo;

  //final MessageReplay messageReplay;

  const ReplayMessageCardForSender({
    super.key,
    this.showCloseButton = false,
    required this.repliedMessageType,
    required this.text,
    required this.isMe, required this.repliedTo,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 5,
          top: 5,
          bottom: 8,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: isMe ? AppColorss.senderMessageReplyColor.withOpacity(0.1) : AppColorss.myMessageReplyColor.withOpacity(0.35)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 4),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ReplayMessageContent(
                  repliedMessageType: repliedMessageType,
                  text: text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReplayMessageCardForBottomField extends StatelessWidget {
  final bool showCloseButton;
  final MessageType repliedMessageType;
  final String text;
  final bool isMe;
  final String repliedTo;

  //final MessageReplay messageReplay;

  const ReplayMessageCardForBottomField({
    super.key,
    this.showCloseButton = false,
    required this.repliedMessageType,
    required this.text,
    required this.isMe, required this.repliedTo,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(padding: const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color:  AppColorss.thirdColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    isMe ? 'Replying to Yourself' : 'Replying to $repliedTo',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppColorss.textColor2.withOpacity(0.7),
                      fontFamily: 'Arabic'
                    ),
                  ),
                ),

                if (showCloseButton)
                  GestureDetector(
                    onTap: () {
                      ChatCubit.get(context).cancelReplay();
                    },
                    child:  Icon(
                      Icons.close,
                      size: 16,
                      color: AppColorss.iconsColors,
                    ),
                  )
              ],
            ),
            const SizedBox(height: 8),
            ReplayMessageContent(
              repliedMessageType: repliedMessageType,
              text: text,
            ),
          ],
        ),
      ),
    );
  }
}

class ReplayMessageContent extends StatelessWidget {
  //final MessageReplay messageReplay;
  final MessageType repliedMessageType;
  final String text;

  const ReplayMessageContent({
    super.key,
    required this.repliedMessageType,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    switch (repliedMessageType) {
      case MessageType.text:
        return Text(
          text,
          textDirection: TextDirection.rtl,
          style:  TextStyle(color: AppColorss.textColor1.withOpacity(0.9),
            fontSize: 12, fontFamily: 'Arabic',   overflow: TextOverflow.visible,
            height: 0.9
            ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,

        );
      case MessageType.image:
        return
          const Row(
          children:  [
            Icon(Icons.image,color: Colors.white,),
            SizedBox(width: 4,),
            Text(
              'Photo',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        );
      case MessageType.gif:
        return const Row(
          children:  [
            Icon(Icons.gif , color: Colors.white70,),
            Text(
              'GIF',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        );
      case MessageType.video:
        return const Row(
          children:  [
            Icon(Icons.videocam, color: Colors.white70,),
            Text(
              'Video',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        );
      case MessageType.audio:
        return const Row(
          children:  [
            Icon(
              Icons.mic,
              size: 18,
              color: Colors.white,
            ),
            Text(
              'Voice message',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        );
      default:
        return Text(
          text,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white),
        );
    }
  }
}



