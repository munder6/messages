import 'package:flutter/material.dart';

import '../../../../../core/utils/thems/my_colors.dart';
import '/core/extensions/extensions.dart';

class SettingBottomText extends StatelessWidget {
  const SettingBottomText({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'from\n',
              style: context.titleMedium!.copyWith(fontSize: 8),
            ),
            TextSpan(
              text: 'Munder A. Ghanem',
              style: TextStyle(color:AppColorss.textColor1, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}