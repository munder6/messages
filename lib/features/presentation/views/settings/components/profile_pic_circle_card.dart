import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_me_app/features/presentation/controllers/auth_cubit/auth_cubit.dart';
import 'package:message_me_app/features/presentation/views/settings/components/name_card.dart';

import '../../../../../core/utils/thems/my_colors.dart';
import '../../../../domain/entities/user.dart';
import '../../../components/my_cached_net_image.dart';
import '../../../components/update_profile_pic_model_bottom_sheet.dart';

class ProfilePicCircleCard extends StatelessWidget {
  const ProfilePicCircleCard({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    UserEntity? newUser;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UpdateProfilePicSuccessState) {
        AuthCubit.get(context).getCurrentUser();
        }
        if(state is GetCurrentUserSuccessState){
          newUser = AuthCubit.get(context).userEntity;
        }
      },
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 20,right: 20),
          decoration: BoxDecoration(
            color: AppColorss.thirdColor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                children: [
                  const SizedBox(width: 30),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: (){selectImageFromGallery(context);},
                    child: Hero(
                      tag: user.uId,
                      child: MyCachedNetImage(
                        imageUrl: newUser?.profilePic ?? user.profilePic,
                        radius: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text("Enter Your name and add an optional\nprofile picture", textAlign: TextAlign.start, style: TextStyle(color: AppColorss.textColor2),)
                ],
              ),
              const SizedBox(height: 8),
               Row(
                children: [
                   const SizedBox(width: 48.7),
                   InkWell(
                     highlightColor: Colors.transparent,
                     splashColor: Colors.transparent,
                     focusColor: Colors.transparent,
                     hoverColor: Colors.transparent,
                     onTap: (){showUpdateProfilePicModelBottomSheet(context);},
                       child: const Text("Edit", style: TextStyle(color: AppColorss.red),))
                ],
              ),
              NameCard(user: user)
            ],
          ),
        );
      },
    );
  }
}
