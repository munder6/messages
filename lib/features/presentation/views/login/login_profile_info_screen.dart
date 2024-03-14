// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_me_app/core/services/firebase_fcm_token.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import '../settings/components/profile_card.dart';
import '../settings/components/profile_pic_circle_card.dart';
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
  TextEditingController statusController = TextEditingController();

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
                  const SizedBox(height: 20),
                  const SetProfilePhoto(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                             Row(
                              children: [
                                Text("Enter Your Name", style: TextStyle(fontSize: 14, color: AppColorss.textColor1),),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Divider(color: AppColorss.thirdColor, height: 0,),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColorss.primaryColor,
                              ),
                              child: TextField(
                                style:  TextStyle(color: AppColorss.textColor1, fontSize: 18),
                                cursorHeight: 20,
                                controller: nameController,
                                decoration:  InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  filled: false,
                                  hintStyle: TextStyle(fontSize: 15, color: AppColorss.textColor3, ),
                                  hintText: AppStrings.typeYourNameHere,
                                  enabledBorder: InputBorder.none,
                                  fillColor: AppColorss.thirdColor
                                ),
                              ),
                            ),
                            Divider(color: AppColorss.thirdColor, height: 0,),

                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Enter Your Status", style: TextStyle(fontSize: 14, color: AppColorss.textColor1),),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Divider(color: AppColorss.thirdColor, height: 0,),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColorss.primaryColor,
                              ),
                              child: TextField(
                                style:  TextStyle(color: AppColorss.textColor1, fontSize: 18),
                                cursorHeight: 20,
                                controller: statusController,
                                decoration:  InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    filled: false,
                                    hintStyle: TextStyle(fontSize: 15, color: AppColorss.textColor3, ),
                                    hintText: 'your status ...',
                                    enabledBorder: InputBorder.none,
                                    fillColor: AppColorss.thirdColor
                                ),
                              ),
                            ),
                            Divider(color: AppColorss.thirdColor, height: 0,),

                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 50, width: 450,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColorss.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0))
                      ),
                      onPressed: () {
                        if (nameController.text.length > 3) {
                         // String fcmToken = FirebaseService.fcmToken!; // Assuming you have a function to retrieve the FCM token
                          cubit.saveUserDataToFirebase(
                            name: nameController.text,
                            fcmToken: "fcmToken",
                            status: statusController.text
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

