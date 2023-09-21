import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:message_me_app/core/utils/constants/strings_manager.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:message_me_app/core/enums/messge_type.dart';
import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../core/utils/thems/my_colors.dart';
import '../../../../../domain/entities/message.dart';
import '../../../../components/my_cached_net_image.dart';
import '../../../../controllers/chat_cubit/chat_cubit.dart';
import '../message_content/message_content.dart';
import 'message_replay_card.dart';

class SenderMessageCard extends StatefulWidget {
  final Message message;
  final bool isFirst;
  final bool isLast;

  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.isFirst,
    required this.isLast,
  }) : super(key: key);

  @override
  _SenderMessageCardState createState() => _SenderMessageCardState();
}

class _SenderMessageCardState extends State<SenderMessageCard> {
  String profilePic = 'https://cdn.landesa.org/wp-content/uploads/default-user-image.png';

  @override
  void initState() {
    super.initState();
    _getUserImage();
  }

  void _getUserImage() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final userId = widget.message.senderId;
      final userSnapshot = await firestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        final userData = userSnapshot.data();
        setState(() {
          profilePic = userData?['profilePic'] as String? ?? 'https://cdn.landesa.org/wp-content/uploads/default-user-image.png';
        });
      }
    } catch (e) {
      print('Error getting user image: $e');
    }
  }
  void _showMessageMenu(BuildContext context) {
    final messageText = widget.message.text;
    showModalBottomSheet(
      backgroundColor: AppColorss.thirdColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.copy,
                  color: AppColorss.iconsColors,
                ),
                title: Text(
                  AppStringss.copyMessage,
                  style: TextStyle(color: AppColorss.textColor1),
                ),
                onTap: () {
                  _copyMessageText( context,  messageText);
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                title: Text(
                  AppStringss.deleteMessage,
                  style: TextStyle(color: AppColorss.textColor1),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  _deleteMessage(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _copyMessageText(BuildContext context, String messageText) {
    Clipboard.setData(ClipboardData(text: messageText));
    Fluttertoast.showToast(
      msg: AppStringss.messageCopied,
      toastLength: Toast.LENGTH_LONG,
      textColor: AppColorss.textColor1,
      backgroundColor: AppColorss.thirdColor,
      gravity: ToastGravity.CENTER,
    );
    // scaffoldMessenger.showSnackBar(
    //   SnackBar(content: Text('Message copied')),
    // );
  }

  void _deleteMessageFromFirestoreForMe(BuildContext context) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final userId = widget.message.senderId;
      final chatId = widget.message.receiverId;
      await firestore
          .collection('users')
          .doc(chatId)
          .collection('chats')
          .doc(userId)
          .collection('messages')
          .doc(widget.message.messageId)
          .delete();
      Fluttertoast.showToast(
        msg: AppStringss.doneDeleteForMe,
        toastLength: Toast.LENGTH_LONG,
        textColor: AppColorss.textColor1,
        backgroundColor: AppColorss.thirdColor,
        gravity: ToastGravity.CENTER,
      );
    } catch (e) {
      print('Error deleting message: $e');
      Fluttertoast.showToast(
        msg: 'Error Message Deleted For Me',
        toastLength: Toast.LENGTH_LONG,
        textColor: AppColorss.textColor1,
        backgroundColor: AppColorss.thirdColor,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void _deleteMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColorss.thirdColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title:  Text(
            AppStringss.deleteMessage,
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            AppStringss.confirmDelete,
            style: TextStyle(color: AppColorss.textColor1),
          ),
          actions: [
            TextButton(
              child: Text(
                AppStringss.no,
                style: TextStyle(color: AppColorss.textColor2),
              ),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
            TextButton(
              child: Text(
                AppStringss.deleteForMe,
                style: TextStyle(
                  color: AppColorss.myMessageColor,
                ),
              ),
              onPressed: () {
                _deleteMessageFromFirestoreForMe(context);
                Navigator.pop(context); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isReplying = widget.message.repliedMessage.isNotEmpty;
    return Column(
      children: [
        if (isReplying)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 50),
              Container(
                height: 35,
                width: 3,
                decoration: BoxDecoration(
                    color: AppColorss.replyContainerColor,
                    borderRadius: BorderRadius.circular(50)
                ),
                child: const Text(""),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4, bottom: 4),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: context.width(0.36),
                  ),
                  child: ReplayMessageCardForSender(
                    text: widget.message.repliedMessage,
                    repliedMessageType: widget.message.repliedMessageType,
                    isMe: widget.message.repliedTo == widget.message.senderName,
                    repliedTo: widget.message.repliedTo,
                  ),
                ),
              ),

            ],
          ),
        SwipeTo(
          onRightSwipe: () {
            ChatCubit.get(context).onMessageSwipe(
              message: widget.message.text,
              isMe: false,
              messageType: widget.message.messageType,
              repliedTo: widget.message.senderName,
            );
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 2.3,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 9)),
                  widget.isLast
                      ? MyCachedNetImage(
                    imageUrl: profilePic,
                    radius: 13,
                  )
                      : const Padding(padding: EdgeInsets.symmetric(horizontal: 13)),
                  const SizedBox(width: 5),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: context.width(0.6),
                      maxHeight: 600,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: widget.message.messageType == MessageType.image || widget.message.messageType == MessageType.video ? 0 : 5),
                      decoration: BoxDecoration(
                        color: widget.message.messageType == MessageType.image || widget.message.messageType == MessageType.video
                            ? Colors.transparent
                            : AppColorss.senderMessageColor,
                        borderRadius: BorderRadius.only(
                          topRight:  const Radius.circular(20),
                          bottomLeft: widget.isLast ? Radius.circular(widget.message.messageType == MessageType.audio || widget.isFirst ? 20 : 20) : const Radius.circular(5),
                          bottomRight: const Radius.circular(20),
                          topLeft: widget.isFirst ? Radius.circular(widget.message.messageType == MessageType.audio || widget.isFirst ? 20 : 20) : const Radius.circular(5),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          GestureDetector(
                            onLongPress: () {
                              _showMessageMenu(context);
                            },
                            child: MessageContent(message: widget.message, isMe: false, isLast: widget.isLast,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}




class TypingMessageCard extends StatefulWidget {
  final Message message;
  final bool isFirst;
  final bool isLast;

  const TypingMessageCard({
    Key? key,
    required this.message,
    required this.isFirst,
    required this.isLast,
  }) : super(key: key);

  @override
  _TypingMessageCardState createState() => _TypingMessageCardState();
}

class _TypingMessageCardState extends State<TypingMessageCard> {
  String profilePic = 'https://cdn.landesa.org/wp-content/uploads/default-user-image.png';

  @override
  void initState() {
    super.initState();
    _getUserImage();
  }

  void _getUserImage() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final userId = widget.message.senderId;
      final userSnapshot = await firestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        final userData = userSnapshot.data();
        setState(() {
          profilePic = userData?['profilePic'] as String? ?? 'https://cdn.landesa.org/wp-content/uploads/default-user-image.png';
        });
      }
    } catch (e) {
      print('Error getting user image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.symmetric(horizontal: 9)),
                widget.isLast
                    ? MyCachedNetImage(
                  imageUrl: profilePic,
                  radius: 13,
                )
                    : const Padding(padding: EdgeInsets.symmetric(horizontal: 13)),
                const SizedBox(width: 5),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: context.width(0.6),
                    maxHeight: 600,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: widget.message.messageType == MessageType.image || widget.message.messageType == MessageType.video ? 0 : 5),
                    decoration: BoxDecoration(
                      color: widget.message.messageType == MessageType.image || widget.message.messageType == MessageType.video
                          ? Colors.transparent
                          : AppColorss.senderMessageColor,
                      borderRadius: BorderRadius.only(
                        topRight:  const Radius.circular(20),
                        bottomLeft: widget.isLast ? Radius.circular(widget.message.messageType == MessageType.audio || widget.isFirst ? 20 : 20) : const Radius.circular(5),
                        bottomRight: const Radius.circular(20),
                        topLeft: widget.isFirst ? Radius.circular(widget.message.messageType == MessageType.audio || widget.isFirst ? 20 : 20) : const Radius.circular(5),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                          child: Lottie.asset("assets/images/typing.json", width: 40),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}








