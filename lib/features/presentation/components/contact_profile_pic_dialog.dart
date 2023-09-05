import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/constants/assets_manager.dart';
import '../../domain/entities/contact_chat.dart';

Future<void> showContactProfilePicDialog(
  BuildContext context, {
  required ContactChat contact,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Color.fromRGBO(18, 32, 49, 1.0),
        scrollable: true,
        contentPadding: EdgeInsets.zero,
        alignment: Alignment.topCenter,
        content: Stack(
          children: [
            Hero(
              tag: contact.contactId,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft: Radius.circular(20)),
                child: CachedNetworkImage(
                  width: 400,
                  height: 300,
                  imageUrl: contact.profilePic,
                  placeholder: (context, url) => Stack(
                    children: [
                      Image.asset(AppImage.genericProfileImage),
                      const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    ],
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    AppImage.genericProfileImage,
                  ),
                  //height: 180.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 8,
                ),
                
                child: Text(
                  contact.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              FluentIcons.chat_24_regular,
              color: Colors.white,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              FluentIcons.call_24_regular,
              color: Colors.white,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              FluentIcons.video_24_regular,
              color: Colors.white,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              FluentIcons.info_24_regular,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      );
    },
  );
}
