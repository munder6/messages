import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/utils/thems/my_colors.dart';
import '../../../../../core/functions/navigator.dart';
import '../../../../../core/utils/constants/assets_manager.dart';
import '../../../../../core/utils/routes/routes_manager.dart';
import '../../../../domain/entities/user.dart';
import '../../../components/loader.dart';
import '../../../components/my_cached_net_image.dart';
import '../../../controllers/auth_cubit/auth_cubit.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthCubit.get(context).getCurrentUser(),
      builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
            UserEntity user = AuthCubit.get(context).userEntity!;
              return InkWell(
              onTap: () {
                navigateTo(context, Routes.profileRoute, arguments: user);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: Container(
                  height: 82,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    elevation: 0,
                    color:  AppColorss.thirdColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.5),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child:  CachedNetworkImage(
                              imageUrl: user.profilePic,
                              placeholder: (context, url) => Stack(
                                children: [
                                  Image.asset(AppImage.genericProfileImage, fit: BoxFit.fill,),
                                ],
                              ),
                              errorWidget: (context, url, error) =>
                                  Image.asset(AppImage.genericProfileImage),
                              //height: 180.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: TextStyle(color:AppColorss.textColor1, fontSize: 20),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                Text(
                                  user.status,
                                  style: TextStyle(color: AppColorss.textColor3),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                          //const Spacer(),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColorss.primaryColor,
                            child: Image.asset(
                              AppImage.qrCode,
                              width: 20,
                              color:  Colors.blue[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
        }
        return  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              //set border radius more than 50% of height and width to make circle
            ),
            elevation: 0,
            color:  AppColorss.thirdColor,
            child: SizedBox(
              height: 74,
              width: 500,
              child: Lottie.asset("assets/images/loading.json", width: 10),
            ),
          ),
        );
      },
    );
  }
}
