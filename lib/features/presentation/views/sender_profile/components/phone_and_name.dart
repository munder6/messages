import 'package:flutter/material.dart';
import 'package:message_me_app/core/utils/constants/strings_manager.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';

import '/core/extensions/extensions.dart';

class PhoneAndName extends StatelessWidget {
  final String name;
  final String phoneNum;
  final String status;

  const PhoneAndName({
  super.key,
  required this.name,
  required this.phoneNum,
  required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        const SizedBox(height: 35),
        Text(
          name,
          style: context.headlineMedium!.copyWith(fontSize: 22, color: AppColorss.textColor1),
        ),
        const SizedBox(height: 10),
        Text(
          phoneNum,
          style: context.bodyMedium!.copyWith(color: AppColorss.textColor1),
        ),
        const SizedBox(height: 10),
        Text(
          status,
          style: context.bodyMedium!.copyWith(color: AppColorss.textColor1),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}