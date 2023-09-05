import 'package:flutter/material.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';


class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final Widget? title;

  const LoginAppBar({
    super.key,
    this.actions,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColorss.primaryColor,
      title: title,
      actions: actions,
    );
  }



  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
