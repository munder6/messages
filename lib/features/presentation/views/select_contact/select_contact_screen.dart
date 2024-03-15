import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants/strings_manager.dart';
import '../../../../core/utils/thems/my_colors.dart';
import '../../controllers/select_contact_cubit/select_contact_cubit.dart';
import 'components/contacts_not_on_whatsapp_list.dart';
import 'components/contacts_on_whatsapp_list.dart';
import 'components/select_contact_appbar.dart';
import 'components/new_group_contact_community_buttons_List.dart';

class SelectContactScreen extends StatelessWidget {
  const SelectContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SelectContactCubit.get(context).getAllContacts().then((value) {
        SelectContactCubit.get(context).getContactsOnMessageMe();
        SelectContactCubit.get(context).getContactsNotOnMessageMe();
      });
      return BlocConsumer<SelectContactCubit, SelectContactState>(
        listener: (context, state) {},
        builder: (context, state) {
          SelectContactCubit cubit = SelectContactCubit.get(context);
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: Scaffold(
              backgroundColor: AppColorss.thirdColor,
              appBar: SelectContactAppBar(
                numOfContacts:
                    cubit.contactOnWhats.length + cubit.contactNotOnMessageMe.length,
                state: state,
              ),
              body: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const NewGroupContactCommunityButtonsList(),
                      SmallText(AppStringss.contactOnMessageMe),
                      ContactsOnMessageMeList(
                        contactOnWhats: cubit.contactOnWhats,
                      ),
                       SmallText(AppStringss.inviteToMessageMe),
                      ContactsNotOnMessageMeList(
                        contactNotMessageMe: cubit.contactNotOnMessageMe,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}




class SmallText extends StatelessWidget {
  final String text;

  const SmallText(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(text, style: TextStyle(color: AppColorss.textColor1),),
    );
  }
}
