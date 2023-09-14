import 'package:flutter/material.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import '/core/extensions/time_extension.dart';
import '../../../../../domain/entities/message.dart';

class TimeSentWidget extends StatelessWidget {
  const TimeSentWidget({
  super.key,
  required this.message,
  required this.isMe,
  required this.textColor,
  });

  final Message message;
  final bool isMe;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4, bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            Text(message.timeSent.amPmMode, style: const TextStyle(color: Colors.white, fontSize: 10,fontFamily: 'Arabic'),),
        ],
      ),
    );
  }
}