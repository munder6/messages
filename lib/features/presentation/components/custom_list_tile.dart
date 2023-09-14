import 'package:flutter/material.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import '../../../core/utils/constants/assets_manager.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subTitle;
  final String? time;
  final Widget? titleButton;
  final int numOfMessageNotSeen;
  final VoidCallback onTap;
  final VoidCallback? onLeadingTap;

  const CustomListTile({
    super.key,
    this.leading,
    required this.title,
    this.subTitle,
    this.time,
    this.numOfMessageNotSeen = 0,
    this.titleButton,
    required this.onTap,
    this.onLeadingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              //set border radius more than 50% of height and width to make circle
            ),
            elevation: 0,
            //color: const Color.fromRGBO(40, 49, 58, 1.0),
           color: Colors.transparent,
            child: Column(
              children: <Widget> [
                SizedBox(
                  height: 70,
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 6),
                    onTap: onTap,
                    leading: leading ??
                        InkWell(
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          autofocus: true,
                          onTap: onLeadingTap,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Image.asset(AppImage.genericProfileImage),
                          ),
                        ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            //style: context.headlineSmall,
                            style: TextStyle(color: AppColorss.textColor1, fontFamily: 'Arabic', fontSize: 16, fontWeight: FontWeight.normal),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        if (time != null)
                          Text(
                            time!,
                            style: numOfMessageNotSeen>0
                                ? TextStyle(color: AppColorss.textColor1, fontSize: 12, fontWeight : FontWeight.normal)
                                : TextStyle(fontSize: 12, color: AppColorss.textColor2, fontWeight : FontWeight.normal),
                          ),
                        if (titleButton != null)
                          SizedBox(
                            height: 18,
                            child: titleButton!,
                          ),
                      ],
                    ),
                    subtitle: subTitle != null
                        ? Row(
                          children: [
                            const SizedBox(height: 33),
                            //Icon(Icons.done_all,size: 20,),
                            Expanded(
                              child: Text(
                                subTitle!,
                                style: TextStyle(fontFamily: 'Arabic',color: numOfMessageNotSeen >0  ?  AppColorss.textColor1 : AppColorss.textColor2, fontWeight:  FontWeight.normal),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            if ( numOfMessageNotSeen >0 )
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: AppColorss.myMessageColor2,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(
                                    numOfMessageNotSeen.toString(),
                                    style: const TextStyle(color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                          ],
                        )
                        : const SizedBox(),
                  ),
                ),
               // Divider(height: 0,)
              ],
            ),
          ),
        Divider(color: AppColorss.textColor1.withOpacity(0.3),height: 0,indent: 79,),
      ],
    );
  }
}
