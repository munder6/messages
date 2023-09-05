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
    return Column(
      children: [
        CustomListTile(
          onTap: () {
            FlutterContacts.openExternalInsert();
          },
          leading: CircleAvatar(
            backgroundColor: AppColorss.iconsColors2,
            child:  Icon(
              Icons.person_add,
              color: AppColorss.iconsColors,
            ),
          ),
          title: AppStrings.newContact,
          titleButton: GestureDetector(
            onTap: () {
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                AppImage.qrCode,
                color: AppColorss.iconsColors,
              ),
            ),
          ),
        ),
        // CustomListTile(
        //   onTap: () {},
        //   leading: CircleAvatar(
        //     backgroundColor: context.colorScheme.secondary,
        //     child: const Icon(
        //       Icons.groups,
        //       color: Colors.white70,
        //     ),
        //   ),
        //   title: AppStrings.newCommunity,
        // ),
      ],
    );
  }
}
