import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import '../../../../../core/utils/constants/assets_manager.dart';
import '../../../../../core/utils/constants/strings_manager.dart';
import '../../../components/custom_list_tile.dart';

class NewGroupContactCommunityButtonsList extends StatelessWidget {
  const NewGroupContactCommunityButtonsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: AppColorss.thirdColor,
          borderRadius: BorderRadius.circular(15)
      ),
      margin: const EdgeInsets.only(top: 5, right: 15, left: 15, bottom: 15),
      child: CustomListTileForSelectContact(
        subTitle: "Add A New contact",
        onTap: () {
          FlutterContacts.openExternalInsert();
        },
        leading: CircleAvatar(
          backgroundColor: AppColorss.secondaryColor,
          child: const Icon(
            FluentIcons.person_add_24_regular,
            color: AppColorss.red,
          ),
        ),
        title: AppStringss.newContact,
        // titleButton: GestureDetector(
        //   onTap: () {
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.all(4.0),
        //     child: Image.asset(
        //       AppImage.qrCode,
        //       color: AppColorss.iconsColors,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
