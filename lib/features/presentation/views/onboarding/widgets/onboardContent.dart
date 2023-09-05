import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key, required this.image, required this.title, required this.description,
  });

  final String image , title , description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Lottie.asset(image,height: 150, fit: BoxFit.fill),
        const SizedBox(height: 30),
        Text(title,
          textAlign: TextAlign.center,
          style:
          Theme.of(context).textTheme.headlineMedium?.copyWith
            (color: AppColorss.textColor1, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 5),
        Text(description,
            textAlign: TextAlign.center,
            style:
            Theme.of(context).textTheme.headlineSmall?.copyWith
              (color: AppColorss.textColor2, fontWeight: FontWeight.w500, fontSize: 18)),
        const Spacer()
      ],
    );
  }
}