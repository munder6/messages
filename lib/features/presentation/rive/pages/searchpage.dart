import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/thems/my_colors.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : AppColorss.primaryColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45.0),
          child: AppBar(
            systemOverlayStyle:  SystemUiOverlayStyle(
              statusBarColor: AppColorss.primaryColor,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: AppColorss.thirdColor,
              systemNavigationBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
              systemNavigationBarDividerColor: AppColorss.thirdColor,
              systemNavigationBarContrastEnforced: true,
              systemStatusBarContrastEnforced: true,
            ),
            elevation: 0,
            backgroundColor: AppColorss.primaryColor,
            centerTitle: true,
            title: const Text(
              'Stories',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Default',
                  fontSize: 20
              ),
            ),
          ),
      ),
     body: Column(
       children: [
       ],
     ),
    );
  }
}











