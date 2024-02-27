import 'package:flutter/material.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';

class DotIndicator extends StatelessWidget {


  final bool isActive;

  const DotIndicator({
    super.key, this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isActive ? 8 : 4,
      width: 8,
      decoration: BoxDecoration(
          color: isActive ? AppColorss.red : Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(50))
      ), duration: const Duration(milliseconds: 300),
    );
  }
}