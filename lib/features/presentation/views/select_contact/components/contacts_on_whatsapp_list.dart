import 'package:flutter/material.dart';

import '../../../../../core/functions/navigator.dart';
import '../../../../../core/utils/routes/routes_manager.dart';
import '../../../../../core/utils/thems/my_colors.dart';
import '../../../components/custom_list_tile.dart';
import '../../../components/my_cached_net_image.dart';

class ContactsOnMessageMeList extends StatelessWidget {
  final Map<String, dynamic> contactOnWhats;

  const ContactsOnMessageMeList({
  super.key,
  required this.contactOnWhats,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contactOnWhats.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var contact = contactOnWhats.values.toList()[index];
        return Column(
          children: [
            CustomListTile(
              title: contact['name'],
              onTap: () {
                navigateTo(
                  context,
                  Routes.chatRoute,
                  arguments: {
                    'uId': contact['uId'],
                    'name': contact['name'],
                  },
                );
              },
              onLeadingTap: () {},
              subTitle: contact['status'],
              leading: MyCachedNetImage(
                imageUrl: contact['profilePic'],
                radius: 22,
              ),
            ),
            Divider(indent: 75, height: 0.1,color: AppColorss.dividersColor.withOpacity(0.5),),
          ],
        );
      },
    );
  }
}