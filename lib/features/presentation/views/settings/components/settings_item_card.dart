import 'package:flutter/material.dart';
import '../../../../../core/utils/thems/my_colors.dart';

class SettingsItemCard extends StatelessWidget {
  const SettingsItemCard({
  super.key,
  required this.item,
  });

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item['onTab'],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            //set border radius more than 50% of height and width to make circle
          ),
          elevation: 0,
          color: AppColorss.thirdColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Row(
              children: [
                Icon(
                  item['icon'],
                  color: AppColorss.iconsColors,
                  size: 26,
                ),
                const SizedBox(
                  width: 20,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${item['title']}',
                        style: TextStyle(color: AppColorss.textColor1, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
