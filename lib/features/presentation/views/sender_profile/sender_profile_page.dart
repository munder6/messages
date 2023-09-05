import 'package:flutter/material.dart';
import '../../../../core/utils/thems/my_colors.dart';
import '../../../domain/entities/user.dart';
import '../../components/custom_network_image.dart';
import 'components/phone_and_name.dart';
import 'components/sender_profile_icons.dart';

class SenderUserProfilePage extends StatelessWidget {
  final UserEntity user;

  const SenderUserProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme:  IconThemeData(color: AppColorss.iconsColors),
          backgroundColor: AppColorss.primaryColor,
        ),
        backgroundColor: AppColorss.primaryColor,
        body: Center(
          child: Column(
            children: [
              CustomNetworkImage(imageUrl: user.profilePic),
              PhoneAndName(
                name: user.name,
                phoneNum: user.phoneNumber,
                status: user.status,
              ),
              const SenderProfileIcons(),
            ],
          ),
        ),
      ),
    );
  }
}
