import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/constants/strings_manager.dart';
import '../../../../../core/utils/thems/my_colors.dart';



class SettingsCards extends StatefulWidget {


  const SettingsCards({super.key});


  @override
  State<SettingsCards> createState() => _SettingsCardsState();
}

class _SettingsCardsState extends State<SettingsCards> {

  void Function()? onPressed;
  String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 18,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
      decoration: BoxDecoration(
          color: AppColorss.thirdColor,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    backgroundColor: AppColorss.thirdColor,
                    title:  Text(AppStringss.logout, style: const TextStyle(color: Colors.red)),
                    content: Text(AppStringss.confirmLogout, style: TextStyle(color: AppColorss.textColor1),),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child:  Text(AppStringss.no, style: const TextStyle(color: Colors.blue),),
                      ),
                      TextButton(
                        onPressed: onPressed,
                        child:  Text(AppStringss.yes, style: const TextStyle(color: Colors.red),),
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(left: 0, right: 20, top: 0, bottom: 0),
              decoration: BoxDecoration(
                  color: AppColorss.thirdColor,
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width - 18,
              child: Card(
                elevation: 0,
                color: AppColorss.thirdColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(5)),
                        height: 30,
                        width: 27,
                        padding: const EdgeInsets.all(0),
                        child: const Icon(
                          FluentIcons.sign_out_24_regular,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10), // Adjust the spacing as needed
                      Text(
                        AppStringss.logout,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
