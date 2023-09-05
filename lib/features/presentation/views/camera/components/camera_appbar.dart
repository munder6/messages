import 'package:flutter/material.dart';
import '../../../../../core/functions/navigator.dart';
import '../../../../../core/utils/thems/my_colors.dart';

class CameraAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onFlashPressed;
  final bool isFlashOn;

  const CameraAppBar({
    super.key,
    required this.onFlashPressed,
    required this.isFlashOn,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      leading: IconButton(
        // iconSize: 30,
        onPressed: () {
          navigatePop(context);
        },
        icon:  Icon(Icons.clear, color: AppColorss.iconsColors,),
      ),
      actions: [
        IconButton(
          onPressed: onFlashPressed,
          icon: Icon(
            color: AppColorss.iconsColors,
            isFlashOn ? Icons.flash_on : Icons.flash_off,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
