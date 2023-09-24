import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../../../core/utils/thems/my_colors.dart';
import '/features/presentation/views/chat/components/message_content/time_sent_widget.dart';
import '../../../../../domain/entities/message.dart';

class TextWidget extends StatefulWidget {
  const TextWidget({
    Key? key,
    required this.message,
    required this.isMe,
    required this.isLast,
  }) : super(key: key);

  final Message message;
  final bool isMe;
  final bool isLast;

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  bool showTimeSentWidget = false; // Track the visibility of the TimeSentWidget

  Widget _buildContent(String content) {
    final RegExp regexEmoji =
    RegExp(r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff]|\ud83e[\udd00-\udfff])');

    final Iterable<Match> matches = regexEmoji.allMatches(content);
    if (matches.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(7.0),
        child: Text(
          textAlign: widget.isMe ?TextAlign.start : TextAlign.end,
          overflow:  TextOverflow.visible,
          textDirection: TextDirection.rtl,
          content,
          style: TextStyle(
            fontSize: 15.0,
            color: widget.isMe ? Colors.white : AppColorss.textColor1,
            fontFamily: 'Arabic'
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(5),
      child: RichText(
        textAlign: TextAlign.end,
        overflow:  TextOverflow.visible,
        textDirection: TextDirection.rtl,
        text: TextSpan(
          children: [
            for (var t in content.characters)
              TextSpan(
                text: t,
                style: TextStyle(
                  letterSpacing: 0,
                  height: 1.1,
                  fontSize: regexEmoji.allMatches(t).isNotEmpty ? (Platform.isAndroid ? 15.0 : 20.0) : 15.0,
                  fontFamily: 'Arabic',
                  color: widget.isMe ? Colors.white : AppColorss.textColor1,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showTimeSentWidget = !showTimeSentWidget; // Toggle the visibility of the TimeSentWidget
        });
      },
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: _buildContent(widget.message.text),
          ),
          // if (showTimeSentWidget) // Conditionally show the TimeSentWidget
          //   TimeSentWidget(
          //     message: widget.message,
          //     isMe: widget.isMe,
          //     textColor: Colors.white54,
          //   ),
        ],
      ),
    );
  }
}
