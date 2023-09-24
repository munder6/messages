import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/services/firebase_fcm_token.dart';
import '../../../../core/utils/constants/strings_manager.dart';
import '../../../../core/utils/routes/routes_manager.dart';
import '../../../../core/utils/thems/my_colors.dart';
import '../../../../test.dart';
import '../../controllers/auth_cubit/auth_cubit.dart';
import '../setting_pages/select_Languges.dart';
import '../setting_pages/storage_and_data.dart';
import 'components/profile_card.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? profilePicUrl;
  String? userName;

  bool _isSwitchedOn = true;

  List<Map<String, dynamic>> settingsItems = [
    {
      'title': 'Notifications',
      'icon': FluentIcons.alert_28_regular,
    },
    {
      'title': 'Privacy',
      'icon': FluentIcons.lock_closed_24_regular,
    },
    {
      'title': 'Chats',
      'icon': FluentIcons.chat_24_regular,
    },
    {
      'title': 'Storage and data',
      'icon': FluentIcons.data_area_24_regular,
    },
    {
      'title': 'App language',
      'icon': FluentIcons.local_language_24_regular,
    },
    {
      'title': 'Help',
      'icon': FluentIcons.chat_help_24_regular,
    },
    {
      'title': 'Logout',
      'icon': FluentIcons.sign_out_24_regular,
    },
  ];

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
    List<Map<String, dynamic>> filteredItems = List.from(settingsItems);
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
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                children: [
                  const SizedBox(width: 21),
                  Text(
                    AppStringss.settings,
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
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
                          setState(() {
                            filteredItems = settingsItems
                                .where((item) =>
                                item['title']
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColorss.textColor1,
                          fontSize: 15,
                          fontFamily: 'Arabic',
                        ),
                        cursorColor: AppColorss.iconsColors,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FluentIcons.search_24_regular,
                            color: AppColorss.textColor3,
                            size: 23,
                          ),
                          hintText: AppStringss.search,
                          hintStyle: TextStyle(
                            color: AppColorss.textColor3,
                            fontFamily: 'Arabic',
                            fontSize: 17,
                            height: 1.029,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          enabled: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              const ProfileCard(),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
                decoration: BoxDecoration(
                    color: AppColorss.thirdColor,
                    borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width - 18,
                height: 50,
                child: Card(
                  elevation: 0,
                  color: AppColorss.thirdColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 30,
                          width: 27,
                          padding: const EdgeInsets.all(0),
                          child: Icon(
                            _isSwitchedOn
                                ? FluentIcons.alert_28_regular
                                : FluentIcons.alert_off_28_regular,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10), // Adjust the spacing as needed
                         Text(
                          AppStringss.notifications,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const Spacer(), // This will push the switch to the rightmost side
                        Switch(
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
                                      .update({'fcmToken': fcmToken});
                                } else {
                                  final currentUser = FirebaseAuth.instance.currentUser;
                                  final currentUserId = currentUser?.uid;
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(currentUserId)
                                      .update({'fcmToken': 'Notifications Off'});
                                }
                              });
                              await _saveSwitchState(newValue);
                            } catch (error) {}
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width - 18,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
                decoration: BoxDecoration(
                    color: AppColorss.thirdColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 0, right: 20, top: 0, bottom: 0),
                      decoration: BoxDecoration(
                          color: AppColorss.thirdColor,
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width - 18,
                      child: InkWell(
                        // onTap: (){
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => const Test()),
                        //   );
                        // },
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
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 30,
                                  width: 27,
                                  padding: const EdgeInsets.all(0),
                                  child: const Icon(
                                    FluentIcons.lock_closed_24_regular,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10), // Adjust the spacing as needed
                                 Text(
                                  AppStringss.privacy,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 0, indent: 60,),
                    Container(
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
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.circular(5)),
                                height: 30,
                                width: 27,
                                padding: const EdgeInsets.all(0),
                                child: const Icon(
                                  FluentIcons.chat_24_regular,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 10), // Adjust the spacing as needed
                               Text(
                                AppStringss.chats,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 0, indent: 60,),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StorageAndData()),
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
                                      color: Colors.yellowAccent.shade700,
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 30,
                                  width: 27,
                                  padding: const EdgeInsets.all(0),
                                  child: const Icon(
                                    FluentIcons.data_area_24_regular,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10), // Adjust the spacing as needed
                                 Text(
                                  AppStringss.storeData,
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
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width - 18,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
                decoration: BoxDecoration(
                    color: AppColorss.thirdColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LanguageSelector()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 0, right: 20, top: 0, bottom: 0),
                        height: 50,
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
                                      color: Colors.deepOrangeAccent,
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 30,
                                  width: 27,
                                  padding: const EdgeInsets.all(0),
                                  child: const Icon(
                                    FluentIcons.local_language_24_regular,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10), // Adjust the spacing as needed
                                 Text(
                                  AppStringss.lang,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 0, indent: 60),
                    Container(
                      margin: const EdgeInsets.only(left: 0, right: 20, top: 0, bottom: 0),
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColorss.thirdColor,
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width - 18,
                      child: InkWell(
                        onTap: (){
                           launchUrl(Uri.parse("tel:+970599987676"));
                        },
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
                                      color: Colors.blue.shade700,
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 30,
                                  width: 27,
                                  padding: const EdgeInsets.all(0),
                                  child: const Icon(
                                    FluentIcons.chat_help_24_regular,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                 Text(
                                  AppStringss.help,
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
              ),
              const SizedBox(height: 20),
              Container(
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
              ),
              const SizedBox(height: 30,),
            ],
          ),
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
