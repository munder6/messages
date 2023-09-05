import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import '../../../../../core/utils/constants/strings_manager.dart';

class SenderProfileIcons extends StatelessWidget {
   const SenderProfileIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        ButtonWidget(text: AppStrings.call,icon: FluentIcons.call_24_regular),
        SizedBox(width: 20),
        ButtonWidget(text: AppStrings.video,icon: FluentIcons.video_24_regular),
        SizedBox(width: 20),
        ButtonWidget(text: AppStrings.search,icon: FluentIcons.search_24_regular),

      ],
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  const ButtonWidget({
    super.key, required this.icon, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        Icon(
          icon,
          size: 40,
          color: AppColorss.iconsColors,
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style:  TextStyle(
            fontSize: 12,
            color: AppColorss.textColor2,
          ),
        ),
      ],
    );
  }
}