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
              return Center(
                child: InkWell(
                  splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  navigateTo(context, Routes.profileRoute, arguments: user);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.5),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child:  CachedNetworkImage(
                              imageUrl: user.profilePic,
                              placeholder: (context, url) => Stack(
                                children: [
                                  Image.asset(AppImage.genericProfileImage, fit: BoxFit.fill,),
                                ],
                              ),
                              errorWidget: (context, url, error) =>
                                  Image.asset(AppImage.genericProfileImage),
                              height: 120.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15),
                              Text(
                                user.name,
                                style: TextStyle(color:AppColorss.textColor1, fontSize: 20),
                              ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    user.phoneNumber,
                                    style: TextStyle(color: AppColorss.textColor3),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(width : 5),
                                  CircleAvatar(
                                    radius: 2.5,
                                    backgroundColor: AppColorss.textColor3,
                                  ),
                                  const SizedBox(width : 5),
                                  Text(
                                    user.status,
                                    style: TextStyle(color: AppColorss.textColor3),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 15),

                                ],
                              )
                            ],
                          ),
                          //const Spacer(),

                        ],
                      ),
                    ),
                  ),
                ),
            ),
              );
        }
        return  SizedBox(
          height: 201,
          child: Center(
            child: SizedBox(
              child: Lottie.asset("assets/images/loading.json", width: 30),
            ),
          ),
        );
      },
    );
  }
}
