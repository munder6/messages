import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:message_me_app/core/functions/navigator.dart';
import 'package:message_me_app/core/utils/routes/routes_manager.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import 'package:message_me_app/features/presentation/views/onboarding/widgets/dotindicator.dart';
import 'package:message_me_app/features/presentation/views/onboarding/widgets/onboardContent.dart';
import 'package:message_me_app/features/presentation/views/onboarding/widgets/onboeardData.dart';
import '../../../../../core/services/firebase_fcm_token.dart';



class OnBoarding extends StatefulWidget {
  static const String routeName = '/welcome-page';
  const OnBoarding({Key? key}) : super(key: key);



  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _pageIndex = 0 ;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColorss.primaryColor,
      body: Stack(
        children: [
         // Lottie.asset("assets/images/loading1123.json"),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 110),
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (index){
                        setState(() {
                          _pageIndex = index;
                        });
                      },
                      itemCount: demoData.length,
                      controller: _pageController,
                        itemBuilder: (context, index) =>
                            OnboardContent(
                          image: demoData[index].image,
                          title: demoData[index].title,
                          description: demoData[index].description,
                        )
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(demoData.length, (index) =>
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: DotIndicator(isActive: index == _pageIndex,),
                          )),
                    ],
                  ),
                 // const Spacer(),
                  const SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: 50, width: 450,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColorss.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0))
                          ),
                          onPressed: () {
                            navigateAndReplace(context, Routes.loginRoute);
                            print('FCM Token: ${FirebaseService.fcmToken}');
                          },
                          child:  const Text(
                            "Start Messaging",
                            style: TextStyle(fontFamily: 'Default', fontWeight: FontWeight.w500, fontSize: 20),)
                      ),
                    ),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

