import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/constants/strings_manager.dart';
import '../../../../../core/utils/thems/my_colors.dart';
import '../../../../domain/entities/user.dart';

class AboutCard extends StatefulWidget {
  const AboutCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserEntity user;

  @override
  _AboutCardState createState() => _AboutCardState();
}

class _AboutCardState extends State<AboutCard> {
  final TextEditingController _aboutController = TextEditingController();

  @override
  void dispose() {
    _aboutController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _aboutController.text = widget.user.status;
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:  AppColorss.thirdColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Change About', style: TextStyle(color: AppColorss.textColor1),),
        content: Container(
          decoration: BoxDecoration(
              color: AppColorss.secondaryColor,
              borderRadius: BorderRadius.circular(15)
          ),
          child: TextField(
            cursorColor: AppColorss.textColor1,
            keyboardAppearance: Brightness.dark,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(color: AppColorss.textColor1,  fontFamily: 'Arabic',),
            controller: _aboutController,
            decoration:  InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              prefixIcon: Icon(
                Icons.edit,
                color: AppColorss.textColor1,
                size: 18,
              ),
              hintText: 'Your New About',
              hintStyle: TextStyle(
                color: AppColorss.textColor1,
                fontFamily: 'Arabic',
                fontSize: 15,
              ),
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              enabled: true,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              String newAbout = _aboutController.text;
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.user.uId)
                  .update({'status': newAbout})
                  .then((value) {
                print('About updated successfully');
              }).catchError((error) {
                print('Failed to update about: $error');
              });


              Navigator.pop(context); // Close the dialog
            },
            child: Text('Save', style: TextStyle(color: Colors.blue),),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: _showAboutDialog,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColorss.thirdColor
            ),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: ListTile(
              leading:  Icon(FluentIcons.info_24_regular, color: AppColorss.iconsColors),
              title:   Text(
                widget.user.status,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color:AppColorss.textColor1, fontSize: 20),
              ),
              trailing: Icon(
                FluentIcons.edit_24_regular,
                color: AppColorss.iconsColors,
              ),

            ),
          ),
        ),
      ],
    );
  }
}
