import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/utils/constants/strings_manager.dart';
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


class SetProfilePhoto extends StatelessWidget {
  const SetProfilePhoto({super.key});


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthCubit.get(context).getCurrentUser(),
      builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          UserEntity user = AuthCubit.get(context).userEntity!;
          return Center(
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
                      // const SizedBox(
                      //   width: 16,
                      // ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     const SizedBox(height: 15),
                      //     Text(
                      //       user.name,
                      //       style: TextStyle(color:AppColorss.textColor1, fontSize: 20),
                      //     ),
                      //     // const SizedBox(
                      //     //   height: 5,
                      //     // ),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Text(
                      //           user.phoneNumber,
                      //           style: TextStyle(color: AppColorss.textColor3),
                      //           overflow: TextOverflow.ellipsis,
                      //         ),
                      //         const SizedBox(width : 5),
                      //         CircleAvatar(
                      //           radius: 2.5,
                      //           backgroundColor: AppColorss.textColor3,
                      //         ),
                      //         const SizedBox(width : 5),
                      //         Text(
                      //           user.status,
                      //           style: TextStyle(color: AppColorss.textColor3),
                      //           overflow: TextOverflow.ellipsis,
                      //         ),
                      //         const SizedBox(height: 15),
                      //
                      //       ],
                      //     )
                      //   ],
                      // ),

                      //const Spacer(),

                    ],

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




class EditCard extends StatelessWidget {
  const EditCard({super.key});


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthCubit.get(context).getCurrentUser(),
      builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          UserEntity user = AuthCubit.get(context).userEntity!;
          return  Container(
            height: 50,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 12),
            decoration: BoxDecoration(
                color: AppColorss.thirdColor,
                borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width - 18,
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                navigateTo(context, Routes.profileRoute, arguments: user);
              },
              child: Card(
                elevation: 0,
                color: AppColorss.thirdColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        height: 30,
                        width: 27,
                        padding: const EdgeInsets.all(0),
                        child: const Icon(
                          FluentIcons.camera_edit_20_regular,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10), // Adjust the spacing as needed
                      Text(
                        AppStringss.editProfile,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return  SizedBox(
         height: 62,
        );
      },
    );
  }
}
