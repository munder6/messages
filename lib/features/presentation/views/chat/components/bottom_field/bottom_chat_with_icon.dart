import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:giphy_get/giphy_get.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import '../../../../../../core/shared/commen.dart';
import '../../../../controllers/bottom_chat_cubit/bottom_chat_cubit.dart';
import '../../../../controllers/chat_cubit/chat_cubit.dart';
import 'bottom_chat_field.dart';
import 'emoji_picker_widget.dart';

class BottomChatWithIcon extends StatefulWidget {
  final String receiverId;

  const BottomChatWithIcon({
    super.key,
    required this.receiverId,
  });

  @override
  State<BottomChatWithIcon> createState() => _BottomChatWithIconState();
}

class _BottomChatWithIconState extends State<BottomChatWithIcon> {
  final TextEditingController messageController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        //hideEmojiContainer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<  BottomChatCubit, BottomChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        BottomChatCubit cubit = BottomChatCubit.get(context);
        return WillPopScope(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: BottomChatField(
                  receiverId: widget.receiverId,
                  focusNode: focusNode,
                  isShowEmoji: cubit.isShowEmoji,
                  messageController: messageController,
                  onTextFieldValueChanged: (val) {
                      cubit.onTextFieldValChanged(val);
                      if (val.isNotEmpty) {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        final currentUserId = currentUser?.uid;
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(currentUserId)
                            .update({'isTyping': true});
                      }
                      if (val.isEmpty) {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        final currentUserId = currentUser?.uid;
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(currentUserId)
                            .update({'isTyping': false});
                      }
                      },

                  toggleEmojiKeyboard: () =>
                      cubit.toggleEmojiKeyboard(focusNode),
                ),
              ),
              // Offstage(
              //   offstage: !cubit.isShowEmoji,
              //   child: BlocBuilder<ChatCubit, ChatState>(
              //     builder: (context, state) {
              //       return EmojiPickerWidget(
              //         messageController: messageController,
              //         onGifButtonTap: () {
              //           selectGif(ChatCubit.get(context));
              //         },
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
          onWillPop: () {
            if (cubit.isShowEmoji) {
              cubit.hideEmojiContainer();
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
        );
      },
    );
  }

  // void selectGif(ChatCubit cubit) async {
  //   final gif = await pickGif(context);
  //   sendGifMessage(gif, cubit);
  // }

  // void sendGifMessage(GiphyGif? gif, ChatCubit cubit) {
  //   if (gif != null) {
  //     cubit.sendGifMessage(
  //       receiverId: widget.receiverId,
  //       gifUrl: gif.url!,
  //     );
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }
}
