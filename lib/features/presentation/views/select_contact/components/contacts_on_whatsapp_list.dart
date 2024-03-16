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
        return Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: AppColorss.thirdColor,
            borderRadius: BorderRadius.circular(15)
          ),
          margin: const EdgeInsets.only(top: 0, right: 15, left: 15, bottom: 15),
          child: CustomListTileForSelectContact(
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
              radius: 20,
            ),
          ),
        );
      },
    );
  }
}