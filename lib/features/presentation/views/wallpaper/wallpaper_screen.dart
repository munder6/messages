import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message_me_app/core/functions/navigator.dart';
import 'package:message_me_app/core/utils/constants/assets_manager.dart';
import 'package:message_me_app/features/presentation/controllers/chat_background_cubit/chat_background_cubit.dart';

class WallpaperScreen extends StatelessWidget {
  const WallpaperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(29, 39, 51, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(27, 30, 35, 1.0),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromRGBO(29, 39, 51, 1.0),
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Color.fromRGBO(29, 39, 51, 1.0),
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Color.fromRGBO(29, 39, 51, 1.0),
          systemNavigationBarContrastEnforced: true,
          systemStatusBarContrastEnforced: true,
        ),
        title: const Text(
          'Custom Wallpaper',
        ),
      ),
      body: GridView(
        physics: const BouncingScrollPhysics(),
        // if you want IOS bouncing effect, otherwise remove this line
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: wallpapers.map((name) {
          return InkWell(
            onTap: (){
              ChatBackgroundCubit.get(context).changeBackground(name);
              navigatePop(context);
            },
            child: Card(
              child: Image.asset(
                name,
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

List<String> wallpapers = [
  AppImage.chat1,
  AppImage.chat2,
  AppImage.chat3,
  AppImage.chat4,
  AppImage.chat5,
  AppImage.chat6,
  AppImage.chat7,
];
