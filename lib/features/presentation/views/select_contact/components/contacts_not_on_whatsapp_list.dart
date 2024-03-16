import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import '../../../../../core/utils/constants/font_manager.dart';
import '../../../../../core/utils/constants/strings_manager.dart';
import '../../../components/custom_list_tile.dart';

class ContactsNotOnMessageMeList extends StatelessWidget {
  final List<Contact> contactNotMessageMe;

  const ContactsNotOnMessageMeList({
  super.key,
  required this.contactNotMessageMe,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contactNotMessageMe.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(

          margin: const EdgeInsets.only(top: 2, right: 15, left: 15, bottom: 4),
          decoration: BoxDecoration(
              color: AppColorss.thirdColor,
              borderRadius: BorderRadius.circular(15)
          ),
          child: CustomListTileForSelectContact(
            title: contactNotMessageMe[index].displayName,
            subTitle: 'Tap to invite ${contactNotMessageMe[index].displayName} to MessageMe',
            onTap: () {},
            titleButton: TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.invite,
                style: TextStyle(
                  color: AppColorss.textColor1,
                  fontWeight: FontWeightManager.medium,
                ),
              ),
            ),
            onLeadingTap: () {},
          ),
        );
      },
    );
  }
}