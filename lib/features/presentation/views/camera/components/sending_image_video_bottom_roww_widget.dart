import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';


class SendingImageVideoBottomRowWidget extends StatelessWidget {
  const SendingImageVideoBottomRowWidget({
  super.key, required this.onSendButtonTaped
  });

  final VoidCallback onSendButtonTaped;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blue,
            child: GestureDetector(
              onTap: onSendButtonTaped,
              child:  Icon(
                FluentIcons.send_24_regular,
                color:Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
