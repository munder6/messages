import 'package:flutter/material.dart';

import '../../../core/utils/thems/my_colors.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final double? width;

  const DefaultButton({
    super.key,
    required this.text,
    required this.onPress,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, width: 450,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColorss.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0))
        ),
        onPressed: onPress,
        child: Text(
            text,
          style: const TextStyle(fontFamily: 'Default', fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
    );
  }
}
