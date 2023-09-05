import 'package:cloud_firestore/cloud_firestore.dart';
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
                borderSide: BorderSide(
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
            child: Text('Save', style: TextStyle(color: Colors.blue),),
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
          ListTile(
            leading: Icon(Icons.person, color: AppColorss.iconsColors),
            title: Text(AppStrings.name, style: TextStyle(color: AppColorss.textColor2),),
            subtitle: Text(
              widget.user.name,
              style: TextStyle(color: AppColorss.textColor1, fontSize: 20),
            ),
            trailing: Icon(
              Icons.edit,
              color: AppColorss.iconsColors,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 20, bottom: 10),
            child: Text(
              AppStrings.thisIsNotYourUser,
              style:  TextStyle(color:AppColorss.textColor2, fontSize: 14),
            ),
          ),
           Padding(
            padding: EdgeInsets.only(left: 70),
            child: Divider(
              color: AppColorss.dividersColor,
            ),
          ),
        ],
      ),
    );
  }
}
