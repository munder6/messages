// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class MyColors {
  /// Base Colors
  final Color black = Colors.black;
  final Color black1 = const Color(0xFF121212);
  final Color black2 = const Color(0xFF18171d); // 900
  final Color black3 = const Color(0xFF242329); // 900
  final Color onyx = const Color(0xFF45444B); // 900
  final Color textBlack = const Color(0XFF4F5054);
  final Color grey = Colors.grey;
  final Color abbey = const Color(0xFF464648);
  final Color dimGray = const Color(0xFF666666);
  final Color textIconColorGray = Colors.grey[300]!;
  final Color white = Colors.white;
  final Color white1 = const Color(0xFFFAFAFA);
  final Color white2 = const Color(0xFFECECF4);
  final Color transparent = Colors.transparent;
  final Color shadow = const Color.fromRGBO(33, 22, 156, 0.1);
  final Color blackLight=  const Color(0XFF646464);
  final Color secondary = const Color(0xFF666666); //primary
  final Color primary = const Color(0x00ffffff); //primary2
  final Color primary1 = const Color(0x00ffffff); //primaryLight1

  final Color lightGreen = const Color(0Xffffffff);
  final Color teaGreen = const Color(0Xffffffff);

  final Color checkMarkBlue = const Color(0Xffffffff);

  final Color round = const Color(0Xffffffff);//coloo
  final Color timeBackgroundColor = const Color(0Xffffffff);
}


class AppColorss {
  static bool get isWhite =>
      WidgetsBinding.instance.window.platformBrightness == Brightness.light;
  static const Color thirdColor23 = Color.fromARGB(255, 255, 255, 255);
  static final Color primaryColor = isWhite ? Colors.white : Colors.black;
  static final Color secondaryColor = isWhite ? Colors.white70 : Colors.grey.shade900;
  static final Color focusMenuColor = isWhite ? Colors.white70 : const Color.fromARGB(255, 239, 239, 239);
  static final Color thirdColor = isWhite ? const Color.fromARGB(255, 239, 239, 239) : Color.fromARGB(255, 40, 39, 39);
  static final Color thirdColor2 = isWhite ? const Color.fromARGB(255, 255, 255, 255) : Color.fromARGB(255, 50, 49, 49);
  static final Color back = isWhite ? Colors.grey.shade900 : Colors.grey.shade900;
  static const Color myMessageColor =   Color.fromARGB(255, 255, 36, 36) ;
  static const Color myMessageColor1 =   Color.fromARGB(255, 243, 72, 72) ;
  static const Color myMessageColor2 =  Color.fromARGB(255, 169, 6, 6);
  static final Color senderMessageColor = isWhite ? const Color.fromARGB(255, 239, 239, 239) : const Color.fromARGB(255, 38, 38, 38);
  static const Color replyMessageColor = Color.fromARGB(255, 239, 239, 239);
  static final Color textColor1 = isWhite ? Colors.black : Colors.white;
  static final Color textColor2 = isWhite ? Colors.black54 : Colors.white70;
  static final Color textColor3 = isWhite ? Colors.black38 : Colors.white60;
  static final Color textColor4 = isWhite ? Colors.black26 : Colors.white54;
  static final Color iconsColors = isWhite ? Colors.black : Colors.white;
  static final Color iconsColors2 = isWhite ? Colors.white : Colors.white;
  static final Color dividersColor = isWhite ? Colors.black54 : Colors.white70;
  static final Color replyContainerColor = isWhite ? Colors.black38 : Colors.white30;
  static final Color myMessageReplyColor = isWhite ?  const Color.fromARGB(255, 157, 46, 220) : const Color.fromARGB(255, 157, 46, 220);
  static final Color senderMessageReplyColor = isWhite ? Colors.black : Colors.white70;
  static final Color replyContainerFieldColor = isWhite ? Colors.white70 : Colors.grey.shade900;
  static final Color audioActiveSlider = isWhite ? Colors.black87 : Colors.white70;
  static final Color audioNonActiveSlider = isWhite ? Colors.white70 : Colors.black87;
  static final Color dialogColor = isWhite ? Colors.white70 : Colors.black54;
  static final Color timeSentColor = isWhite ? Colors.white70 : Colors.white70;
  static const Color red = Colors.red;
  static const Color test = Color.fromARGB(255, 40, 39, 39);
}


abstract class IColors {

  Color? scaffoldBackgroundColor;
  Color? appBarColor;
  Color? primaryColor;

  //Color? tabBarColor;
  //Color? tapBarSelectedColor;
  //Color? tapBarNormalColor;
  Brightness? brightness;

  ColorScheme? colorScheme;
}

class LightColors implements IColors {
  final MyColors _colors = MyColors();

  @override
  ColorScheme? colorScheme;

  @override
  Color? appBarColor;

  @override
  Color? scaffoldBackgroundColor;

  @override
  Brightness? brightness;

  @override
  Color? primaryColor;

  LightColors() {
    appBarColor = _colors.white;
    scaffoldBackgroundColor = _colors.white;
    primaryColor = _colors.primary;
    colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: _colors.primary,
      //to appbar
      onPrimary: _colors.white1,
      //to text on appbar
      primaryContainer: _colors.white2,
      // to other text on appbar,action icon
      secondary: _colors.secondary,
      secondaryContainer: _colors.primary1,
      //to fab
      onSecondary: _colors.white1,
      error: _colors.black,
      onError: _colors.white1,
      background: _colors.white1,
      onBackground: _colors.black1,
      onSecondaryContainer: _colors.lightGreen,//landing image
      surface: _colors.teaGreen,
      onSurface: _colors.dimGray,
      surfaceVariant: _colors.timeBackgroundColor,
      onSurfaceVariant: _colors.blackLight,
      onInverseSurface: _colors.grey,
      onTertiary: _colors.checkMarkBlue,
      onTertiaryContainer: _colors.onyx,
      onPrimaryContainer: _colors.round
    );
    brightness = Brightness.light;
  }
}



