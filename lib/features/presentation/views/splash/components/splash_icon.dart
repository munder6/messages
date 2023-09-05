import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashIcon extends StatelessWidget {
  const SplashIcon({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Lottie.asset(
          "assets/images/onboarding1.json",
          width: 600,
        ),
      ),
    );
  }
}
