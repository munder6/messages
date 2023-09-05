import 'package:flutter/material.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';

import '../../../../../core/functions/navigator.dart';

class ImageViewTopRowIcons extends StatelessWidget {
  final VoidCallback onCropButtonTaped;
  const ImageViewTopRowIcons({
  super.key, required this.onCropButtonTaped,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          splashRadius: 20,
          iconSize: 30,
          color: AppColorss.iconsColors,
          onPressed: () {
            navigatePop(context);
          },
          icon: const Icon(Icons.clear),
        ),
        const Spacer(),
        IconButton(
          splashRadius: 20,
          color:  AppColorss.iconsColors,
          icon:  Icon(
            Icons.crop_rotate,
            size: 27,
          ),
          onPressed: onCropButtonTaped,
        ),
      ],
    );
  }
}

