import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/thems/my_colors.dart';
import '../../../../../core/utils/constants/strings_manager.dart';
import '../../../../domain/entities/user.dart';

class PhoneCard extends StatelessWidget {
  const PhoneCard({
  super.key,
  required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 35),
             Text("Phone Number", style: TextStyle(color: AppColorss.textColor2),),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 45,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColorss.thirdColor
          ),
          child:   Row(
            children: [
              const SizedBox(width: 10),
              const Icon(FluentIcons.call_24_regular),
              const SizedBox(width: 10),

              Text(
                  user.phoneNumber,
                  style: TextStyle(color:AppColorss.textColor1, fontSize: 20),

              ),
            ],
          ),
        ),
      ],
    );
  }
}
