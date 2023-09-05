import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LandingImage extends StatelessWidget {
  const LandingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "assets/images/onboarding1.json"
    );
  }
}
