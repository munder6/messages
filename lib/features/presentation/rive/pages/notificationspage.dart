import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45.0),
          child: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light,
                systemNavigationBarColor: Colors.black,
                systemNavigationBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
                systemNavigationBarDividerColor: Colors.black,
                systemNavigationBarContrastEnforced: true,
                systemStatusBarContrastEnforced: true
            ),
            elevation: 0,
            backgroundColor: Colors.black,
            centerTitle: true,
            title: const Text(
              'Notifications',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Default',
                  fontSize: 20
              ),
            ),
            // actions: [
            //   IconButton(icon : const Icon(LineIcons.edit, color: Colors.blue, size: 30,),
            //     onPressed: () {Navigator.pushNamed(context, SelectContactsScreen.routeName);},),
            //   IconButton(icon : const Icon(LineIcons.userFriends, color: Colors.blue, size: 30,),
            //     onPressed: () {Navigator.pushNamed(context, CreateGroupScreen.routeName);},),
            // ],
          )
      ),
    );
  }
}
