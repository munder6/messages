import 'package:flutter/material.dart';
import '../../../../core/utils/constants/strings_manager.dart';
import '../../../../core/utils/thems/my_colors.dart';
import '../../../domain/entities/user.dart';
import 'components/about_card.dart';
import 'components/name_card.dart';
import 'components/phone_card.dart';
import 'components/profile_pic_circle_card.dart';

class ProfileScreen extends StatelessWidget {
  final UserEntity user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorss.primaryColor,
          // appBar: AppBar(
          //   elevation: 0,
          //   centerTitle: true,
          //   iconTheme: IconThemeData(color: AppColorss.iconsColors),
          //   backgroundColor:  AppColorss.primaryColor,
          //   // systemOverlayStyle:  SystemUiOverlayStyle(
          //   //     statusBarColor:   AppColorss.primaryColor,
          //   //     statusBarIconBrightness: Brightness.light,
          //   //     systemNavigationBarColor: AppColorss.primaryColor,
          //   //     systemNavigationBarIconBrightness: Brightness.light,
          //   //     statusBarBrightness: Brightness.dark,
          //   //     systemNavigationBarDividerColor: AppColorss.primaryColor,
          //   // ),
          //   title:  Text(AppStrings.profile, style: TextStyle(color: AppColorss.textColor1),),
          // ),
          body: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  },
                      icon: const Icon(Icons.arrow_back_ios)
                  ),
                  const SizedBox(width: 2),
                  Text(
                    AppStringss.settings,
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ProfilePicCircleCard(user: user),
              const SizedBox(height: 30),
              PhoneCard(user: user),
              const SizedBox(height: 30),
              AboutCard(user: user),
            ],
          ),
        );
  }
}






