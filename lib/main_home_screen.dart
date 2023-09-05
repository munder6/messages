import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:message_me_app/features/presentation/rive/rive_utiles.dart';

import 'core/utils/thems/my_colors.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RiveAssets selectedBottomNav = bottomNavs.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorss.primaryColor,
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius:const BorderRadius.only( topRight : Radius.circular(0) ,topLeft : Radius.circular(0) ),
            color: AppColorss.thirdColor,

          ),
          padding: const EdgeInsets.symmetric( vertical: 8),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             ...List.generate(
                 bottomNavs.length, (index) =>
                 GestureDetector(
                   onTap: (){
                     bottomNavs[index].input!.change(true);
                     if (bottomNavs[index] != selectedBottomNav){
                       setState(() {
                         selectedBottomNav = bottomNavs[index];
                       });
                       setState(() {
                         if(bottomNavs[index] == selectedBottomNav){
                           currentPage = index;
                         }
                       });
                     }
                     Future.delayed(const Duration(seconds: 1), (){
                       bottomNavs[index].input!.change(false);
                     });
                   },
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       SizedBox(
                       height : 28,
                       width: 28,
                        child: Opacity(
                   opacity: bottomNavs[index] == selectedBottomNav ? 1 : 0.5,
                     child: ColorFiltered(
                       colorFilter: ColorFilter.mode(AppColorss.iconsColors, BlendMode.srcIn), // Change the color here
                       child: RiveAnimation.asset(
                         bottomNavs.first.scr,
                         artboard: bottomNavs[index].artboard,
                         onInit: (artboard) {
                           StateMachineController controller = RiveUtils.getRiveController(
                               artboard, stateMachineName: bottomNavs[index].stateMachineName);
                           bottomNavs[index].input = controller.findSMI("active") as SMIBool;
                         },
                       ),
                     ),
                   ),
                       ),
                      // AnimatedBar(isActive: bottomNavs[index] == selectedBottomNav,),
                       Text(
                         bottomNavs[index].title,
                         style: TextStyle(
                           color: bottomNavs[index] == selectedBottomNav ? AppColorss.textColor1 : AppColorss.textColor3,
                           fontSize: 12
                         ),
                       )
                     ],
                   ),
                 ))
            ],
          ),
        ),
      ),
      body: pages[currentPage],
    );
  }
}





