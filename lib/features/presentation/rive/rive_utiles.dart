import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:message_me_app/features/presentation/rive/pages/searchpage.dart';
import 'package:message_me_app/features/presentation/views/main_layout/main_layout_screen.dart';
import 'package:message_me_app/features/presentation/views/settings/settings_screen.dart';

class RiveUtils {
  late SMIBool searchTigger;

  static StateMachineController getRiveController(Artboard artboard, {stateMachineName = "State Machine 1"}){
    StateMachineController? controller =
    StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(controller!);
    return controller;
  }
}

class RiveAssets {
    final String artboard, stateMachineName, title, scr;
    late SMIBool? input;

  RiveAssets(this.scr,
      {required this.artboard,
          required this.stateMachineName,
          required this.title,
          this.input});

  set setInput(SMIBool status){
    input = status;
  }
}

List<RiveAssets> bottomNavs = [
  RiveAssets("assets/images/riveicons.riv", artboard: "CHAT", stateMachineName: "CHAT_Interactivity", title: "Chat"),
  //RiveAssets("assets/images/riveicons.riv", artboard: "BELL", stateMachineName: "BELL_Interactivity", title: "Calls"),
  RiveAssets("assets/images/riveicons.riv", artboard: "SETTINGS", stateMachineName: "SETTINGS_Interactivity", title: "Settings"),
];

int currentPage = 0;
List pages = [
  const MainLayoutScreen(),
 // const SearchPage(),
  SettingsScreen(),

];


class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(top: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const  BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.blue
      ),
    );
  }
}