import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/services/firebase_fcm_token.dart';
import '../../../../core/utils/routes/routes_manager.dart';
import '../../controllers/auth_cubit/auth_cubit.dart';
import 'components/profile_card.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isSwitchedOn = true;

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
  }

  Future<void> _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSwitchedOn = prefs.getBool('switchState') ?? false;
    });
  }

  Future<void> _saveSwitchState(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('switchState', newValue);
  }

  @override
  Widget build(BuildContext context) {
    final AuthCubit cubit = AuthCubit.get(context);

    return Scaffold(
      backgroundColor: AppColorss.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColorss.primaryColor,
        //title: Text(AppStrings.settings, style: TextStyle(color: AppColorss.textColor1)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                SizedBox(width: 21),
                Text("Settings", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 35,
              decoration: BoxDecoration(
                color: AppColorss.thirdColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.start,
                      style:  TextStyle(
                        color: AppColorss.textColor1,
                        fontSize: 15,
                        fontFamily: 'Arabic',
                      ),
                      cursorColor: AppColorss.iconsColors,
                      decoration:  InputDecoration(
                        prefixIcon: Icon(
                          FluentIcons.search_24_regular,
                          color: AppColorss.textColor3,
                          size: 23,
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                            color: AppColorss.textColor3,
                            fontFamily: 'Arabic',
                            fontSize: 17,
                            height: 1.029                     ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        enabled: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,)
                ],
              ),
            ),
            const ProfileCard(),
            Container(
              //height:MediaQuery.of(context).size.width - 15,
              width: MediaQuery.of(context).size.width - 18,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 2,bottom: 2),
              decoration: BoxDecoration(
                  color: AppColorss.thirdColor,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                children: [
                  Card(
                    elevation: 0,
                    color : AppColorss.thirdColor,
                    child:  ListTile(
                      trailing: Switch(
                        value: _isSwitchedOn,
                        onChanged: (bool newValue) async {
                          try {
                            setState(() {
                              _isSwitchedOn = newValue;
                              if (_isSwitchedOn) {
                                String fcmToken = FirebaseService.fcmToken!;
                                final currentUser = FirebaseAuth.instance.currentUser;
                                final currentUserId = currentUser?.uid;
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(currentUserId)
                                    .update({'fcmToken' : fcmToken});
                              } else {
                                final currentUser = FirebaseAuth.instance.currentUser;
                                final currentUserId = currentUser?.uid;
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(currentUserId)
                                    .update({'fcmToken' : 'null'});
                              }
                            });
                            await _saveSwitchState(newValue);
                          } catch (error) {
                          }
                        },
                      ),
                      leading: Icon( _isSwitchedOn ? FluentIcons.alert_28_regular : FluentIcons.alert_off_28_regular , size: 35,),
                      title: const Text("Notifications", style: TextStyle(fontSize: 15),),
                      subtitle: const Text("Enable or Disable Notifications", style: TextStyle(fontSize: 12),),
                    ),
                  ),
                  const Divider(height: 0),
                  Card(
                    elevation: 0,
                    color : AppColorss.thirdColor,
                    child: const ListTile(
                      leading: Icon( FluentIcons.lock_closed_24_regular, size: 35,),
                      title: Text("Privacy", style: TextStyle(fontSize: 15),),
                      subtitle: Text("Edit Your Privacy Settings", style: TextStyle(fontSize: 12),),
                    ),
                  ),
                  const Divider(height: 0),
                  Card(
                    elevation: 0,
                    color : AppColorss.thirdColor,
                    child: const ListTile(
                      leading: Icon( FluentIcons.chat_24_regular, size: 35,),
                      title: Text("Chats", style: TextStyle(fontSize: 15),),
                      subtitle: Text("Theme, wallpapers, chat history", style: TextStyle(fontSize: 12),),
                    ),
                  ),
                  const Divider(height: 0),
                  Card(
                    elevation: 0,
                    color : AppColorss.thirdColor,
                    child: const ListTile(
                      leading: Icon( FluentIcons.data_area_24_regular, size: 35,),
                      title: Text("Storage and data", style: TextStyle(fontSize: 15),),
                      subtitle: Text("Network usage, auto download", style: TextStyle(fontSize: 12),),
                    ),
                  ),
                  const Divider(height: 0),
                  Card(
                    elevation: 0,
                    color : AppColorss.thirdColor,
                    child: const ListTile(
                      leading: Icon( FluentIcons.local_language_24_regular, size: 35,),
                      title: Text("App language", style: TextStyle(fontSize: 15),),
                      subtitle: Text("English", style: TextStyle(fontSize: 12),)
                    ),
                  ),
                  const Divider(height: 0),
                  Card(
                    elevation: 0,
                    color : AppColorss.thirdColor,
                    child: const ListTile(
                      leading: Icon( FluentIcons.chat_help_24_regular, size: 35,),
                      title: Text("Help", style: TextStyle(fontSize: 15),),
                      subtitle: Text("Help centre, contact us, privacy policy", style: TextStyle(fontSize: 12),),
                    ),
                  ),
                  const Divider(height: 0),
                  InkWell(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            backgroundColor:  AppColorss.thirdColor,
                            title: const Text('Logout', style: TextStyle(color: Colors.red)),
                            content:  Text('Are you sure you want to logout?', style: TextStyle(color:AppColorss.textColor1),),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: const Text('Cancel', style: TextStyle(color: Colors.blue),),
                              ),
                              TextButton(
                                onPressed: () async {
                                  // Unsubscribe from the 'chats' topic for push notifications
                                  //await FirebaseMessaging.instance.unsubscribeFromTopic('chats');
                                  final currentUser = FirebaseAuth.instance.currentUser;
                                  final currentUserId = currentUser?.uid;
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(currentUserId)
                                      .update({'fcmToken' : 'null'});


                                  // Clear local user-related data
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  await prefs.clear();

                                  // Navigate to the landing screen
                                  navigateAndRemove(context, Routes.landingRoute);

                                  // Sign out the user
                                  cubit.signOut();
                                },
                                child: const Text('Logout', style: TextStyle(color: Colors.red),),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 0,
                      color : AppColorss.thirdColor,
                      child: const ListTile(
                        leading: Icon( FluentIcons.sign_out_24_regular, size: 35,),
                        title: Text("Logout", style: TextStyle(fontSize: 15),),
                        subtitle: Text("Logout From Your Account", style: TextStyle(fontSize: 12),),
                      ),
                    ),
                  ),

                ],
              ),
            )
            // const ProfileCard(),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
            //   child: Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     elevation: 0,
            //     color: AppColorss.thirdColor,
            //     child: ListTile(
            //       leading: Icon(
            //         _isSwitchedOn ?
            //         EvaIcons.bellOutline :EvaIcons.bellOffOutline  , // Replace with the desired icon
            //         color: Colors.white, // Adjust the icon color as needed
            //       ),
            //       title: Text('Notifications'),
            //       trailing: Switch(
            //         value: _isSwitchedOn,
            //         onChanged: (bool newValue) async {
            //           print("Switch value changed to: $newValue");
            //           try {
            //             setState(() {
            //               _isSwitchedOn = newValue;
            //               if (_isSwitchedOn) {
            //                 String fcmToken = FirebaseService.fcmToken!;
            //                 final currentUser = FirebaseAuth.instance.currentUser;
            //                 final currentUserId = currentUser?.uid;
            //                 FirebaseFirestore.instance
            //                     .collection('users')
            //                     .doc(currentUserId)
            //                     .update({'fcmToken' : fcmToken});
            //               } else {
            //                 final currentUser = FirebaseAuth.instance.currentUser;
            //                 final currentUserId = currentUser?.uid;
            //                 FirebaseFirestore.instance
            //                     .collection('users')
            //                     .doc(currentUserId)
            //                     .update({'fcmToken' : 'null'});
            //               }
            //             });
            //             await _saveSwitchState(newValue);
            //           } catch (error) {
            //             print("Error toggling notifications: $error");
            //           }
            //         },
            //       ),
            //
            //
            //
            //
            //
            //
            // ),
            //   ),
            // ),
            //
            // ...List<Widget>.generate(
            //   _settingItems.length,
            //       (index) => SettingsItemCard(
            //     item: _settingItems[index],
            //   ),
            // ),
            // const SizedBox(height: 20),
            // const SettingBottomText(),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SettingsScreen(),
  ));
}
