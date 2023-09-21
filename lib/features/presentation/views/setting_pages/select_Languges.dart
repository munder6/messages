import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message_me_app/core/utils/constants/strings_manager.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/thems/my_colors.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({Key? key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late String selectedLanguage;

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString('selectedLanguage');

    setState(() {
      selectedLanguage = savedLanguage ?? 'English';
    });
  }

  Future<void> _saveSelectedLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorss.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColorss.primaryColor,
        title: Text(AppStringss.selectLang),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  await _updateLanguageAndRestart('Arabic');
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 18,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    color: selectedLanguage == 'Arabic'
                        ? Colors.blue
                        : AppColorss.thirdColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Radio(
                        value: 'Arabic',
                        groupValue: selectedLanguage,
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value.toString();
                          });
                        },
                      ),
                      Text("العربية"),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await _updateLanguageAndRestart('English');
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 18,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    color: selectedLanguage == 'English'
                        ? Colors.blue
                        : AppColorss.thirdColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Radio(
                        value: 'English',
                        groupValue: selectedLanguage,
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value.toString();
                          });
                        },
                      ),
                      Text("English"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateLanguageAndRestart(String language) async {
    await _saveSelectedLanguage(language);

    setState(() {
      selectedLanguage = language;
    });

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final currentUserId = currentUser.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({'isEnglish': language == 'English'});
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColorss.thirdColor,
            title: Text(AppStringss.restartRequired),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(child: Text(AppStringss.youNeedToRestartApp)),
                SizedBox(height: 16),
                InkWell(
                  onTap: (){
                    SystemNavigator.pop();
                  },
                    child: Text(AppStringss.restartNow, style: TextStyle(color: Colors.red),))
              ],
            ),
          );
        });
  }
}
