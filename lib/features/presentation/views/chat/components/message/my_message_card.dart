import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../../../../../core/enums/messge_type.dart';
import '../../../../../../core/utils/thems/my_colors.dart';
import '/core/extensions/extensions.dart';
import '../../../../../domain/entities/message.dart';
import '../../../../controllers/chat_cubit/chat_cubit.dart';
import '../message_content/message_content.dart';
import 'message_replay_card.dart';

class MyMessageCard extends StatefulWidget {
  final Message message;
  final bool isFirst;
  final bool isLast;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.isFirst,
    required this.isLast,
  }) : super(key: key);

  @override
  State<MyMessageCard> createState() => _MyMessageCardState();
}

class _MyMessageCardState extends State<MyMessageCard> {
  @override
  Widget build(BuildContext context) {
    final isReplying = widget.message.repliedMessage.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isReplying)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 4, bottom: 4),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: widget.message.messageType == MessageType.video  ? context.width(0.25) : context.width(0.6),
                    ),
                    child: ReplayMessageCard(
                      text: widget.message.repliedMessage,
                      repliedMessageType: widget.message.repliedMessageType,
                      isMe: widget.message.repliedTo == widget.message.senderName,
                      repliedTo: widget.message.repliedTo,
                    ),
                  ),
                ),
              Container(
                height: 35,
                width: 3,
                decoration: BoxDecoration(
                  color: AppColorss.replyContainerColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text(""),
              ),
              const SizedBox(width: 16),
            ],
          ),
        SwipeTo(
          onLeftSwipe: () {
            ChatCubit.get(context).onMessageSwipe(
              message: widget.message.text,
              isMe: true,
              messageType: widget.message.messageType,
              repliedTo: widget.message.senderName,
            );
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(top: 2, right: widget.isFirst ? 5 : 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: context.width(0.6),
                      maxHeight: 600,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: widget.message.messageType == MessageType.image || widget.message.messageType == MessageType.video ? 0 : 5),
                      decoration: BoxDecoration(
                        gradient: (widget.message.messageType == MessageType.image || widget.message.messageType == MessageType.video)
                            ? const LinearGradient(
                          colors: [Colors.transparent, Colors.transparent], // Define your gradient colors
                          begin: Alignment.topLeft, // Adjust the gradient's start position
                          end: Alignment.bottomRight, // Adjust the gradient's end position
                        )
                            : const LinearGradient(
                          stops: [
                            0,
                            1,
                            2
                          ],
                          colors: [AppColorss.myMessageColor2,AppColorss.myMessageColor1, AppColorss.myMessageColor], // Define your gradient colors
                          begin: Alignment.topLeft, // Adjust the gradient's start position
                          end: Alignment.bottomRight, // Adjust the gradient's end position
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          bottomLeft: const Radius.circular(20),
                          bottomRight: widget.isLast ? const Radius.circular(20) : const Radius.circular(5),
                          topRight: widget.isFirst ? const Radius.circular(20) : const Radius.circular(5),
                        ),
                      ),
                      child: GestureDetector(
                        onLongPress: () {
                          _showMessageMenu(context);
                        },
                        child: MessageContent(
                          message: widget.message,
                          isMe: true,
                          isLast : widget.isLast
                        ),
                      ),
                    ),
                  ),
                  if (widget.isFirst) const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showMessageMenu(BuildContext context) {
    final isTextMessage = widget.message.messageType == MessageType.text;
    final messageText = widget.message.text;
    showModalBottomSheet(
      backgroundColor: AppColorss.thirdColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isTextMessage)
              ListTile(
                leading: Icon(Icons.copy, color: AppColorss.iconsColors),
                title: Text('Copy Message', style: TextStyle(color:AppColorss.textColor1)),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  _copyMessageText(context, messageText);
                },
              ),
            if (isTextMessage)
              ListTile(
                leading: Icon(Icons.edit, color: AppColorss.iconsColors),
                title: Text('Edit Message', style: TextStyle(color: AppColorss.textColor1)),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  _editMessage(context);
                },
              ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: Text('Delete Message', style: TextStyle(color: AppColorss.textColor1)),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _deleteMessage(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _copyMessageText(BuildContext context, String messageText) {
    Clipboard.setData(ClipboardData(text: messageText));
    Fluttertoast.showToast(
      msg: 'Message Copied',
      textColor: AppColorss.textColor1,
      backgroundColor: AppColorss.secondaryColor,
      gravity: ToastGravity.CENTER,
    );
  }

  void _editMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedMessage = widget.message.text;
        return AlertDialog(
          backgroundColor:  AppColorss.thirdColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Edit Message', style: TextStyle(color: AppColorss.textColor1),),
          content: Container(
            decoration: BoxDecoration(
                color: AppColorss.secondaryColor,
                borderRadius: BorderRadius.circular(15)
            ),
            child: TextField(
              keyboardAppearance: Brightness.dark,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(color: AppColorss.textColor1, fontFamily: 'Arabic'),
              onChanged: (value) {
                editedMessage = value;
              },
              controller: TextEditingController(text: editedMessage),
              decoration:  InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                fillColor: const Color.fromRGBO(20, 30, 40, 1.0),
                prefixIcon: Icon(
                  Icons.edit,
                  color: AppColorss.iconsColors.withOpacity(0.54),
                ),
                hintText: 'Message ...',
                hintStyle: TextStyle(
                  color: AppColorss.textColor3,
                  fontFamily: 'Nova',
                  fontSize: 16,
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
              child: Text('Cancel', style: TextStyle(color: AppColorss.textColor2),),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Save',style: TextStyle(color: Color.fromRGBO(
                  18, 114, 210, 1.0),),),
              onPressed: () {
                // Update the message in Firebase Firestore
                _updateMessageInFirestore(context, editedMessage);
                Navigator.pop(context); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:  AppColorss.thirdColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Delete Message', style: TextStyle(color: Colors.red),),
          content: Text('Are you sure you want to delete this message?', style: TextStyle(color: AppColorss.textColor1),),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: AppColorss.textColor2),),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Delete For Me' , style : TextStyle(color:  Color.fromRGBO(
                  18, 114, 210, 1.0),),),
              onPressed: () {
                _deleteMessageFromFirestoreForMe(context);
                Navigator.pop(context); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Delete For All' , style : TextStyle(color: Colors.red)),
              onPressed: () {
                _deleteMessageFromFirestoreForAll(context);
                Navigator.pop(context); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteMessageFromFirestoreForMe(BuildContext context) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final userId = widget.message.senderId;
      final chatId = widget.message.receiverId;
      await firestore
          .collection('users')
          .doc(userId)
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(widget.message.messageId)
          .delete();
      Fluttertoast.showToast(
        textColor: AppColorss.textColor1,
        backgroundColor: AppColorss.secondaryColor,
        gravity: ToastGravity.CENTER,
        msg: 'Message Deleted For Me',
        toastLength: Toast.LENGTH_LONG,
      );
    } catch (e) {
      print('Error deleting message: $e');
      Fluttertoast.showToast(
        msg: 'Error Deleting Message',
        toastLength: Toast.LENGTH_LONG,
        textColor: AppColorss.textColor1,
        backgroundColor: AppColorss.secondaryColor,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void _deleteMessageFromFirestoreForAll(BuildContext context) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final userId = widget.message.senderId;
      final chatId = widget.message.receiverId;
      await firestore
          .collection('users')
          .doc(userId)
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(widget.message.messageId)
          .delete();
      await firestore
          .collection('users')
          .doc(chatId)
          .collection('chats')
          .doc(userId)
          .collection('messages')
          .doc(widget.message.messageId)
          .delete();
      Fluttertoast.showToast(
        msg: 'Message Deleted Fo All',
        toastLength: Toast.LENGTH_LONG,
        textColor: AppColorss.textColor1,
        backgroundColor: AppColorss.secondaryColor,
        gravity: ToastGravity.CENTER,
      );

    } catch (e) {
      print('Error deleting message: $e');
      Fluttertoast.showToast(
        msg: 'Error deleting message',
        toastLength: Toast.LENGTH_LONG,
        textColor: AppColorss.textColor1,
        backgroundColor: AppColorss.secondaryColor,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void _updateMessageInFirestore(BuildContext context, String editedMessage) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final userId = widget.message.senderId;
      final chatId = widget.message.receiverId;
      await firestore
          .collection('users')
          .doc(userId)
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(widget.message.messageId)
          .update({
        'text': editedMessage,
      });
      await firestore
          .collection('users')
          .doc(chatId)
          .collection('chats')
          .doc(userId)
          .collection('messages')
          .doc(widget.message.messageId)
          .update({
        'text': editedMessage,
      });
      Fluttertoast.showToast(
        msg: 'Message Updated',
        toastLength: Toast.LENGTH_LONG,
        textColor: AppColorss.textColor1,
        backgroundColor: AppColorss.secondaryColor,
        gravity: ToastGravity.CENTER,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error update message',
        toastLength: Toast.LENGTH_LONG,
        textColor: AppColorss.textColor1,
        backgroundColor: AppColorss.secondaryColor,
        gravity: ToastGravity.CENTER,
      );
      print('Error updating message: $e');
    }
  }
}