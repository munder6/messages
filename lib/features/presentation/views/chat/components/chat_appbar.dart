import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/thems/my_colors.dart';
import '../../../components/my_cached_net_image.dart';
import '/core/extensions/time_extension.dart';
import '/core/functions/navigator.dart';
import '/core/utils/routes/routes_manager.dart';
import '../../../../domain/entities/user.dart';
import '../../../components/loader.dart';
import '../../../controllers/auth_cubit/auth_cubit.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String receiverId;

  const ChatAppBar({
    super.key,
    required this.name,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserEntity>(
        stream: AuthCubit.get(context).getUserById(receiverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          UserEntity userdata = snapshot.data!;
          return AppBar(
            elevation: 0.5,
              shadowColor: AppColorss.iconsColors,
              iconTheme:  IconThemeData(color: AppColorss.iconsColors),
            backgroundColor: AppColorss.primaryColor,
            // systemOverlayStyle:  SystemUiOverlayStyle(
            //   statusBarColor: AppColorss.primaryColor,
            //   statusBarIconBrightness: Brightness.light,
            //   systemNavigationBarColor: AppColorss.primaryColor,
            //   systemNavigationBarIconBrightness: Brightness.light,
            //   statusBarBrightness: Brightness.dark,
            //   systemNavigationBarDividerColor: AppColorss.primaryColor,
            //   systemNavigationBarContrastEnforced: true,
            //   systemStatusBarContrastEnforced: true,
            // ),
            centerTitle: false,
            titleSpacing: 0,
            title: InkWell(
              onTap: () {
                navigateTo(
                  context,
                  Routes.senderUserProfileRoute,
                  arguments: userdata,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
               // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyCachedNetImage(
                    imageUrl: userdata.profilePic,
                    radius: 17,
                  ),
                  const SizedBox(width: 5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name , style:  TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Arabic',
                        fontSize: 17,
                        color: AppColorss.textColor1
                      ),),
                      Row(
                        children: [
                          Text(
                            userdata.isOnline ? 'Online' : userdata.lastSeen.lastSeen,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Arabic',
                              color: AppColorss.textColor1,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 3,
                              backgroundColor: userdata.isOnline ? Colors.green : Colors.transparent,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                color: AppColorss.iconsColors,
                onPressed: () {},
                splashRadius: 20,
                icon: const Icon(FluentIcons.call_28_regular),
              ),
              IconButton(
                color: AppColorss.iconsColors,
                onPressed: () {},
                splashRadius: 20,
                icon: const Icon(FluentIcons.video_28_regular),
              ),
              IconButton(
                color: AppColorss.iconsColors,
                onPressed: () {
                  navigateTo(
                    context,
                    Routes.senderUserProfileRoute,
                    arguments: userdata,
                  );
                },
                splashRadius: 20,
                icon: const Icon(FluentIcons.info_24_regular),
              ),

            ],
          );
        });
  }
  // List<PopUpMenuItemModel> _buttons(context) => [
  //
  //       PopUpMenuItemModel(
  //         name: AppStrings.wallpaper,
  //         onTap: () {
  //           navigateTo(context, Routes.wallpaperRoute);
  //         },
  //       ),
  //     ];

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
