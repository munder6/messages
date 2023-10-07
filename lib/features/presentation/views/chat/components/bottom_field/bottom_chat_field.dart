import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_me_app/core/shared/commen.dart';
import 'package:message_me_app/core/utils/constants/strings_manager.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import 'package:message_me_app/focused_menu.dart';
import '../../../../../../core/functions/navigator.dart';
import '../../../../../../core/shared/message_replay.dart';
import '../../../../../../core/utils/routes/routes_manager.dart';
import '../../../../../../modals.dart';
import '../../../../controllers/chat_cubit/chat_cubit.dart';
import '../message/message_replay_preview.dart';

class BottomChatField extends StatefulWidget {
  final TextEditingController messageController;
  final FocusNode focusNode;
  final Function(String) onTextFieldValueChanged;
  final bool isShowEmoji;
  final VoidCallback toggleEmojiKeyboard;
  final String receiverId;

  const BottomChatField({
    super.key,
    required this.messageController,
    required this.focusNode,
    required this.onTextFieldValueChanged,
    required this.isShowEmoji,
    required this.toggleEmojiKeyboard,
    required this.receiverId,
  });

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  @override
  Widget build(BuildContext context) {
    Brightness keyboardAppearance = Theme.of(context).brightness;
    return Container(
      width: MediaQuery.of(context).size.width - 18,
      margin: const EdgeInsets.only(
        right: 5,
        left: 5,
      ),
      decoration: BoxDecoration(
        color: AppColorss.thirdColor,
        borderRadius:  BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              MessageReplay? messageReplay =
                  ChatCubit.get(context).messageReplay;
              if (messageReplay == null) {
                return const SizedBox();
              }
              return MessageReplayPreview(
                messageReplay: messageReplay,
              );
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: double.infinity,
                    maxWidth: double.infinity,
                    minHeight: 25,
                    maxHeight: 135,
                  ),
                  child: Scrollbar(
                    child: TextField(
                      cursorHeight: 25,
                      textAlign: TextAlign.start,
                      onChanged: widget.onTextFieldValueChanged,
                      controller: widget.messageController,
                      keyboardAppearance: keyboardAppearance,
                      cursorColor: AppColorss.textColor1,
                      focusNode: widget.focusNode,
                      textDirection: TextDirection.rtl,
                      cursorWidth: 1,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      style:  TextStyle(
                        fontSize: 17,
                        height: 1.4,
                        fontFamily: 'Arabic',
                        //color: AppColors.blackLight,
                        color: AppColorss.textColor1,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      decoration:  InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: AppStringss.message,
                        hintStyle:  TextStyle(
                          color: AppColorss.textColor3,
                          fontFamily: 'Arabic',
                          height: 1.4,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              FocusedMenuHolder(
                onPressed: (){},
                openWithTap: true,
                  menuWidth: MediaQuery.of(context).size.width * 0.48,
                  blurSize: 9,
                  animateMenuItems: true,
                  menuOffset: 8,
                  duration : const Duration(milliseconds: 300),
                  menuBoxDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0), // Adjust the radius as needed
                    color:AppColorss.thirdColor, // Change the background color as needed
                  ),
                menuItems: [
                  FocusedMenuItem(
                    backgroundColor : AppColorss.thirdColor2,
                    trailingIcon: Icon(FluentIcons.camera_24_regular, color: AppColorss.iconsColors),
                    title: Text("Photo"),
                      onPressed: () {
                        navigateTo(context, Routes.cameraRoute, arguments: {
                          'uId': widget.receiverId,
                        });
                    },
                  ),
                  FocusedMenuItem(
                    backgroundColor : AppColorss.thirdColor2,
                    title: Text("Video"),
                    trailingIcon: Icon(FluentIcons.video_24_regular, color: AppColorss.iconsColors),
                    onPressed: () async {
                      FileResult? videoResult = await pickVideoFromGallery(context);
                      if (videoResult != null) {
                        navigateTo(context, Routes.sendingVideoViewRoute, arguments: {
                          'uId': widget.receiverId, // Use the variable here
                          'path': videoResult.path,
                        });
                      }
                    },
                  ),
                ],
                leftSide: 0,
                  rightSide: 0,
                child:
                const Padding(
                  padding:  EdgeInsets.only(right: 10.0),
                  child:  Center(
                    child: Icon(
                       FluentIcons.attach_24_regular),
                  ),
                )
                ) ,

              // Container(
              //   color: AppColorss.thirdColor,
              //   child: IgnorePointer(
              //     ignoring: false,
              //     child: PopupMenuButton<String>(
              //       position: PopupMenuPosition.under,
              //       icon: const Icon(FluentIcons.attach_24_regular),
              //       onSelected: (value) {
              //         if (value == 'video') {
              //         } else if (value == 'image') {
              //         }
              //       },
              //       itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              //          PopupMenuItem<String>(
              //           value: 'video',
              //           child: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               IconButton(
              //                 splashColor: Colors.transparent,
              //                 icon : const Icon(FluentIcons.video_24_regular),
              //                 onPressed: () async {
              //                   FileResult? videoResult = await pickVideoFromGallery(context);
              //                   if (videoResult != null) {
              //                     navigateTo(context, Routes.sendingVideoViewRoute, arguments: {
              //                       'uId': widget.receiverId, // Use the variable here
              //                       'path': videoResult.path,
              //                     });
              //                   }
              //                 },
              //               ),
              //               InkWell(
              //                   splashColor: Colors.transparent,
              //                 onTap: () async {
              //                   FileResult? videoResult = await pickVideoFromGallery(context);
              //                   if (videoResult != null) {
              //                     navigateTo(context, Routes.sendingVideoViewRoute, arguments: {
              //                       'uId': widget.receiverId, // Use the variable here
              //                       'path': videoResult.path,
              //                     });
              //                   }
              //                 },
              //                   child: Text('Attach Video', style: TextStyle(color: AppColorss.textColor1),)),
              //             ],
              //           ),
              //         ),
              //          PopupMenuItem<String>(
              //           value: 'image',
              //           child: Row(
              //             children: [
              //               IconButton(
              //                 splashColor: Colors.transparent,
              //                 icon : const Icon(FluentIcons.image_28_regular),
              //                 onPressed: () {
              //                   navigateTo(context, Routes.cameraRoute, arguments: {
              //                     'uId': widget.receiverId,
              //                   });
              //                 },
              //               ),
              //               InkWell(
              //                   splashColor: Colors.transparent,
              //                 onTap: () {
              //                   navigateTo(context, Routes.cameraRoute, arguments: {
              //                     'uId': widget.receiverId,
              //                   });
              //                 },
              //                   child: Text('Attach Image', style: TextStyle(color: AppColorss.textColor1),)),
              //             ],
              //           ),
              //         ),
              //       ],
              //
              //     ),
              //   ),
              // ),

              InkWell(
                onTap:  () {
                    ChatCubit.get(context).sendTextMessage(
                    text: widget.messageController.text.trim(),
                    receiverId: widget.receiverId);
                    widget.messageController.clear();
                    setState(() {
                    widget.messageController.clear();});},
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 157, 46, 220),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 37,
                  width: 37,
                  child: const Column(
                    children: [
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 4.5),
                          Icon(
                            FluentIcons.send_20_filled,
                            color: Colors.white,
                            size: 28,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ),

              const SizedBox(width: 5,)
              // if (messageController.text.isEmpty)
              //   IconButton(
              //     onPressed: () async {
              //       FileResult? videoResult = await pickVideoFromGallery(context);
              //       if (videoResult != null) {
              //         navigateTo(context, Routes.sendingVideoViewRoute, arguments: {
              //           'uId': receiverId, // Use the variable here
              //           'path': videoResult.path,
              //         });
              //       }
              //     },
              //     color: AppColorss.iconsColors,
              //     iconSize: 26,
              //     icon: const Icon(FluentIcons.video_24_regular),
              //   ),
              // if (messageController.text.isEmpty)
              //   IconButton(
              //     onPressed: () {
              //       navigateTo(context, Routes.cameraRoute, arguments: {
              //         'uId': receiverId,
              //       });
              //     },
              //     color: AppColorss.iconsColors,
              //     iconSize: 26,
              //     icon: const Icon(FluentIcons.image_28_regular),
              //   ),

            ],
          ),
        ],
      ),
    );
  }
}
