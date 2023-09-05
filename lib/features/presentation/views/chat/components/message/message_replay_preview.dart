import 'package:flutter/material.dart';

import '../../../../../../core/shared/message_replay.dart';
import 'message_replay_card.dart';

class MessageReplayPreview extends StatelessWidget {
  final MessageReplay messageReplay;

  const MessageReplayPreview({
    super.key,
    required this.messageReplay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color:   Colors.transparent,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      child: ReplayMessageCardForBottomField(
        //messageReplay: messageReplay,
        showCloseButton: true,
        isMe: messageReplay.isMe,
        text: messageReplay.message,
        repliedMessageType: messageReplay.messageType,
        repliedTo: messageReplay.repliedTo,
      ),
    );
  }
}

