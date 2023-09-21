import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/constants/strings_manager.dart';
import '../../../../../core/utils/thems/my_colors.dart';
import '../../../../domain/entities/user.dart';

class NameCard extends StatefulWidget {
  const NameCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserEntity user;

  @override
  _NameCardState createState() => _NameCardState();
}

class _NameCardState extends State<NameCard> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }



  void _showNameDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:  AppColorss.thirdColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Change Name', style: TextStyle(color: AppColorss.textColor1),),
        content: Container(
          decoration: BoxDecoration(
              color: AppColorss.secondaryColor,
              borderRadius: BorderRadius.circular(15)
          ),
          child: TextField(
            cursorColor: AppColorss.textColor1,
            keyboardAppearance: Brightness.dark,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(color: AppColorss.textColor1, fontFamily: 'Arabic'),
            decoration:  InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              prefixIcon: Icon(
                Icons.edit,
                color: AppColorss.iconsColors,
                size: 18,
              ),
              hintText: 'Your Name',
              hintStyle: TextStyle(
                color: AppColorss.textColor1.withOpacity(0.5),
                fontFamily: 'Arabic',
                fontSize: 15,
              ),
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              enabled: true,
            ),
            controller: _nameController,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              String newName = _nameController.text;
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.user.uId)
                  .update({'name': newName})
                  .then((value) {
                print('Name updated successfully');
                setState(() {
                
                });
              }).catchError((error) {
                print('Failed to update name: $error');
              });

              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Save', style: TextStyle(color: Colors.blue),),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showNameDialog,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColorss.thirdColor
            ),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: ListTile(
              leading: Icon(FluentIcons.person_24_regular, color: AppColorss.iconsColors),
              title: Text(
                widget.user.name,
                style: TextStyle(color: AppColorss.textColor1, fontSize: 20),
              ),
              trailing: Icon(
                FluentIcons.edit_24_regular,
                color: AppColorss.iconsColors,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
