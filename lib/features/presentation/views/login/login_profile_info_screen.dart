// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_me_app/core/services/firebase_fcm_token.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import '/core/extensions/extensions.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/constants/strings_manager.dart';
import '../../../../core/utils/constants/values_manager.dart';
import '../../../../core/utils/routes/routes_manager.dart';
import '../../controllers/auth_cubit/auth_cubit.dart';
import '../../controllers/select_contact_cubit/select_contact_cubit.dart';
import 'components/login_appbar.dart';
import 'components/login_profile_pic.dart';

class LoginProfileInfoScreen extends StatefulWidget {
  const LoginProfileInfoScreen({super.key});

  @override
  State<LoginProfileInfoScreen> createState() => _LoginProfileInfoScreenState();
}

class _LoginProfileInfoScreenState extends State<LoginProfileInfoScreen> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SelectContactCubit.get(context).getAllContacts().then((value) {
        SelectContactCubit.get(context).getContactsOnMessageMe();
        SelectContactCubit.get(context).getContactsNotOnMessageMe();
      });
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SaveUserDataToFirebaseLoadingState) {
            navigateAndRemove(context, Routes.loginLoadingRoute);
          }
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Scaffold(
            backgroundColor: AppColorss.primaryColor,
            appBar: LoginAppBar(title: Text("Your Info", style: TextStyle(color: AppColorss.textColor1),),),
            body: Padding(
              padding: const EdgeInsets.all(AppPadding.p18),
              child: Column(
                children: [
                  Text(
                    AppStrings.pleaseProvideYourName,
                    textAlign: TextAlign.center,
                    style: context.titleMedium!.copyWith(color: AppColorss.textColor1),
                  ),
                  Text(
                    "\nAnd You Can Set your Profile Photo Later on Setting",
                    textAlign: TextAlign.center,
                    style: context.titleMedium!.copyWith(color: AppColorss.textColor1 , fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                 // const LoginProfilePic(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColorss.thirdColor,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: TextField(
                            style:  TextStyle(color: AppColorss.textColor1, fontSize: 18),
                            cursorHeight: 20,
                            controller: nameController,
                            cursorColor: const Color.fromARGB(255, 71, 62, 102),
                            decoration:  InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              filled: false,
                              hintStyle: TextStyle(fontSize: 15, color: AppColorss.textColor3, height: 1.5),
                              hintText: AppStrings.typeYourNameHere,
                              enabledBorder: InputBorder.none,
                              fillColor: AppColorss.thirdColor
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 50, width: 450,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(71, 62, 102, 1.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0))
                      ),
                      onPressed: () {
                        if (nameController.text.length > 3) {
                          //String fcmToken = FirebaseService.fcmToken!; // Assuming you have a function to retrieve the FCM token
                          cubit.saveUserDataToFirebase(
                            name: nameController.text,
                            fcmToken: "fcmToken",
                          );
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(fontFamily: 'Default', fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}

