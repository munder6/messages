import 'package:flutter/material.dart';

import '../../../../../core/functions/navigator.dart';

class VideoViewTopRowWidget extends StatelessWidget {
  const VideoViewTopRowWidget({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          splashRadius: 20,
          iconSize: 30,
          color: Colors.white,
          onPressed: () {
            navigatePop(context);
          },
          icon: const Icon(Icons.clear),
        ),
        const Spacer(),
      ],
    );
  }
}