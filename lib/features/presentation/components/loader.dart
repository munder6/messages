import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const SizedBox(height: 14),
        Center(
          child: Lottie.asset("assets/images/loading.json", width: 30),
        ),
      ],
    );
  }
}
