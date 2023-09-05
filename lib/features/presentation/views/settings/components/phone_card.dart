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
      child: ListTile(
        leading:  Icon(Icons.phone, color: AppColorss.iconsColors),
        title:  Text(AppStrings.phone, style: TextStyle(color: AppColorss.textColor3),),
        subtitle: Text(
          user.phoneNumber,
       style: TextStyle(color:AppColorss.textColor1, fontSize: 20),
        ),
      ),
    );
  }
}
