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
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColorss.thirdColor
        ),
        child: ListTile(
          leading:  Icon(FluentIcons.call_24_regular, color: AppColorss.iconsColors),
          title:  Text(
            user.phoneNumber,
            style: TextStyle(color:AppColorss.textColor1, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
