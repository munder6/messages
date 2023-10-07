import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:message_me_app/core/extensions/time_extension.dart';
import 'package:message_me_app/core/utils/constants/strings_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:message_me_app/core/enums/messge_type.dart';
import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../core/utils/thems/my_colors.dart';
import '../../../../../../focused_menu.dart';
import '../../../../../../modals.dart';
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
          iconOnRightSwipe: FluentIcons.arrow_hook_up_right_24_filled,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FocusedMenuHolder(
                    blurSize: 7,
                    animateMenuItems: true,
                    menuOffset: 8,
                    duration : const Duration(milliseconds: 300),
                    menuBoxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0), // Adjust the radius as needed
                      color:AppColorss.thirdColor, // Change the background color as needed
                    ),
                    menuWidth: MediaQuery.of(context).size.width * 0.48,
                    menuItems:  <FocusedMenuItem>[
                      FocusedMenuItem(
                        backgroundColor : AppColorss.thirdColor2,
                        title: Text(widget.message.timeSent.foucesdMenueCard, style: TextStyle(color: AppColorss.textColor2),),
                        onPressed: () {},
                      ),
                      if(widget.message.messageType == MessageType.image)
                        FocusedMenuItem(
                            backgroundColor : AppColorss.thirdColor2,
                            title: Text(AppStringss.save),
                            trailingIcon: const Icon(FluentIcons.arrow_circle_down_24_regular),
                            onPressed: (){
                              _SaveImage(context);
                            }
                        ),
                      if(widget.message.messageType == MessageType.video)
                        FocusedMenuItem(
                            backgroundColor : AppColorss.thirdColor2,
                            title: Text(AppStringss.save),
                            trailingIcon: const Icon(FluentIcons.arrow_circle_down_24_regular),
                            onPressed: (){
                              _saveVideo();
                            }
                        ),
                      FocusedMenuItem(
                        backgroundColor : AppColorss.thirdColor2,
                        trailingIcon: Icon(FluentIcons.arrow_hook_up_right_24_filled, color: AppColorss.iconsColors),
                        title: Text(AppStringss.reply),
                        onPressed: () async {
                          ChatCubit.get(context).onMessageSwipe(
                            message: widget.message.text,
                            isMe: false,
                            messageType: widget.message.messageType,
                            repliedTo: widget.message.senderName,
                          );
                        },
                      ),
                      if(widget.message.isLiked)
                        FocusedMenuItem(
                          backgroundColor : AppColorss.thirdColor2,
                          trailingIcon: Icon(FluentIcons.heart_broken_24_regular, color: AppColorss.iconsColors),
                          title: Text(AppStringss.unlike),
                          onPressed: () async {
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
                              'isLiked': false,
                            });
                            final userId2 = widget.message.receiverId;
                            final chatId2 = widget.message.senderId;
                            await firestore
                                .collection('users')
                                .doc(userId2)
                                .collection('chats')
                                .doc(chatId2)
                                .collection('messages')
                                .doc(widget.message.messageId)
                                .update({
                              'isLiked': false,
                            });
                          },
                        ),
                      if(widget.message.messageType == MessageType.text)
                        FocusedMenuItem(
                          backgroundColor : AppColorss.thirdColor2,
                          trailingIcon: Icon(FluentIcons.copy_24_regular, color: AppColorss.iconsColors),
                          title: Text(AppStringss.copyMessage),
                          onPressed: () {
                            _copyMessageText(context, widget.message.text);
                          },
                        ),
                      FocusedMenuItem(
                        backgroundColor : AppColorss.thirdColor2,
                        trailingIcon: const Icon(FluentIcons.delete_24_regular, color: Colors.red),
                        title: Text(AppStringss.deleteMessage),
                        onPressed: () {
                          _deleteMessage(context);
                        },
                      ),
                    ],
                    onPressed: (){},
                    leftSide: 50,
                    rightSide: 0,
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
                        InkWell(
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onDoubleTap: ()async{
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
                              'isLiked': true,
                            });
                            final userId2 = widget.message.receiverId;
                            final chatId2 = widget.message.senderId;
                            await firestore
                                .collection('users')
                                .doc(userId2)
                                .collection('chats')
                                .doc(chatId2)
                                .collection('messages')
                                .doc(widget.message.messageId)
                                .update({
                              'isLiked': true,
                            });

                            await sendNotification(
                              receiverId: widget.message.senderId,
                              notificationTitle: 'Liked Message',
                              notificationBody: 'You received a liked message from ',
                            );

                          },
                          child: Stack(
                            children: [
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
                                    // image: DecorationImage(
                                    //     image: AssetImage( widget.message.isLiked ?  "assets/images/2MYJbKXE3g.gif" : "")
                                    // )
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      MessageContent(message: widget.message, isMe: false, isLast: widget.isLast,),
                                    ],
                                  ),
                                ),
                              ),
                              widget.message.isLiked ?
                              Positioned(
                                bottom: 0,
                                right: 0, // Align to the left edge
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppColorss.primaryColor
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  child: Container(
                                      width: 20,
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: AppColorss.senderMessageColor
                                      ),
                                      child: const Icon(FluentIcons.heart_28_filled, size: 12,color: Colors.red,)),
                                ),
                              ) : const SizedBox(),
                              if (widget.message.isLiked)
                                const SizedBox(height: 55,)
                            ],
                          ),
                        ),

                      ],
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

  Future<void> sendNotification({
    String? receiverId,
    String? notificationTitle,
    String? notificationBody,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      // Initialize Firebase Cloud Messaging
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

      if (receiverId != null) {
        // Get the receiver's FCM token
        String? receiverToken = await _getReceiverFCMToken(receiverId);

        if (receiverToken != null) {
          // Compose the notification message
          final notificationMessage = RemoteNotification(
            title: notificationTitle,
            body: notificationBody,
          );
          var notificationPayload = {
            'notification': {
              'title': "عرض خاص",
              'body': "لدينا عرض جديد من اجلك !",
            },
            'data': {
              // You can include additional data in the notification payload if needed
            },
            'to': receiverToken,
          };
          // Send the notification
          await _sendNotification(notificationPayload);
          print(receiverToken);

        }
      }
    } catch (e) {
      print('Failed to send notification: $e');
    }
  }
  void _SaveImage(BuildContext context) async {
    var cacheManager = DefaultCacheManager();
    var file = await cacheManager.getSingleFile(widget.message.text);

    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    final savedFile = await file.copy(imagePath);

    final result = await ImageGallerySaver.saveFile(savedFile.path);
    if (result['isSuccess']) {
      Fluttertoast.showToast(
        msg: 'Saved',
        toastLength: Toast.LENGTH_LONG,
        textColor: AppColorss.textColor1,
        backgroundColor: AppColorss.secondaryColor,
        gravity: ToastGravity.CENTER,
      );
    }else {
      Fluttertoast.showToast(
        msg: 'Fail to save Image',
        toastLength: Toast.LENGTH_LONG,
        textColor: AppColorss.textColor1,
        backgroundColor: AppColorss.secondaryColor,
        gravity: ToastGravity.CENTER,
      );
    }

  }
  void _saveVideo() async {
    var cacheManager = DefaultCacheManager();
    var file = await cacheManager.getSingleFile(widget.message.text);

    final directory = await getTemporaryDirectory();
    final videoPath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
    final savedFile = await file.copy(videoPath);

    final result = await ImageGallerySaver.saveFile(savedFile.path, isReturnPathOfIOS: false);
    if (result['isSuccess']) {
      Fluttertoast.showToast(
        msg: 'Video Saved',
        toastLength: Toast.LENGTH_LONG,
        textColor: AppColorss.textColor1,
        backgroundColor: AppColorss.secondaryColor,
        gravity: ToastGravity.CENTER,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Fail to save video',
        toastLength: Toast.LENGTH_LONG,
        textColor: AppColorss.textColor1,
        backgroundColor: AppColorss.secondaryColor,
        gravity: ToastGravity.CENTER,
      );
    }
  }

}





Future<void> _sendNotification(Map<String, dynamic> notificationPayload) async {
  // Replace 'YOUR_SERVER_KEY' with your FCM server key
  String serverKey = 'AAAA5Ax2QCU:APA91bGlbVkZh6kdV1LDNM42PgOMEy1K3YWdVXSlg3d1WwpAbvegRfb8wUpk8G0wsiQ1y1L2pf3brbHxEbexbhW_HKma9cS0QFLb5h4cwGKb2krzaEu2QSpssB1C1HktDFu6mX7gVxrd';

  // Send the notification to the FCM API
  var response = await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    },
    body: jsonEncode(notificationPayload),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification');
  }
}

Future<String?> _getReceiverFCMToken(String receiverId) async {
  String? receiverToken;

  try {
    // Initialize Firestore
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Retrieve the receiver's FCM token from the Firestore database
    final DocumentSnapshot receiverSnapshot =
    await firestore.collection('users').doc(receiverId).get();

    Map<String, dynamic>? receiverData =
    receiverSnapshot.data() as Map<String, dynamic>?;

    if (receiverData != null) {
      // Assuming that 'fcmToken' is the field where the FCM token is stored
      receiverToken = receiverData['fcmToken'] as String?;

      if (receiverToken == null) {
        print('Receiver FCM token is null');
        return null;
      }
    } else {
      print('Receiver data not found');
      return null;
    }
  } catch (e) {
    print('Failed to get receiver FCM token: $e');
    return null;
  }

  return receiverToken;
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
                Stack(
                  children: [

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
              ],
            ),
          ),
        ),
      ],
    );
  }


}








