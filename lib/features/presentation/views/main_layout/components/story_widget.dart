import 'package:flutter/material.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';

class StoryWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 8,
          itemBuilder: (context, index) {
            if (index == 0) {
              // Show button in the first CircleAvatar
              return Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  onTap: () {
                    // navigateTo(context, Routes.cameraStoryRoute, arguments: {
                    //   'uId': userId,
                    // });
                    // print(userId);
                  },
                  child:  CircleAvatar(
                    backgroundColor: AppColorss.thirdColor,
                    radius: 35,
                    child: const Icon(
                      Icons.add,
                      size: 35,
                    ),
                  ),
                ),
              );
            } else {
              // Show regular CircleAvatars for other items with a different button behavior
              return Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  onTap: () {
                    // Perform the desired action when the CircleAvatar is pressed
                    // Add your code here
                    print('CircleAvatar pressed!');
                  },
                  child:  CircleAvatar(
                    backgroundColor: AppColorss.thirdColor,
                    radius: 35,
                    // Add any necessary properties to the CircleAvatar, such as image or initials

                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}