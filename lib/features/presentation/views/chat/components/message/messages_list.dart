import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:message_me_app/core/enums/messge_type.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import 'package:message_me_app/features/presentation/components/loader.dart';
import '/core/extensions/time_extension.dart';
import '../../../../../domain/entities/message.dart';
import '../../../../controllers/chat_cubit/chat_cubit.dart';
import 'sender_message_card.dart';
import 'my_message_card.dart';

class MessagesList extends StatefulWidget {



  final String receiverId;


  const MessagesList({
    Key? key,
    required this.receiverId,
  });

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {






  late ScrollController messageController = ScrollController();
  DateTime? lastFetchedMessageTime;


  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }


  void scrollToBottom() {
    final bottomOffset = messageController.position.maxScrollExtent;
    messageController.animateTo(
      bottomOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Message>>(
        stream: ChatCubit.get(context)
            .getChatMessages(widget.receiverId),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
           return const Loader();
          }


            SchedulerBinding.instance.addPostFrameCallback((_) {
              messageController.animateTo(messageController.position.maxScrollExtent
                , duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,);
            });


          return ListView.builder(
            controller: messageController,
            itemCount: snapshot.data?.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 5),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var message = snapshot.data![index];
              ////////////////////////////////////////////
              bool isFirst = false;
              bool isLast = false;
              bool isLastForSeen = false;
              bool isLastFromSender = false;
              var previousMessage =
              (index > 0) ? snapshot.data![index - 1] : null;

              // Check to make message small bubble for the first message
              if (index == 0 ||
                  message.senderId != previousMessage!.senderId ||
                  !message.timeSent.isSameDay(previousMessage.timeSent)) {
                isFirst = true;
              }

              isLast = (index == snapshot.data!.length - 1) ||
                  (index < snapshot.data!.length - 1 &&
                      message.senderId !=
                          snapshot.data![index + 1].senderId);

              isLastForSeen = (index == snapshot.data!.length - 1);

              String targetSenderId = message.senderId; // Replace 'desiredSenderId' with the senderId you want to check


              for (int i = index + 1; i < snapshot.data!.length; i++) {
                if (snapshot.data![i].senderId == targetSenderId) {
                  // The next message in the snapshot is from the target sender
                  isLastFromSender = false;
                  break;
                } else {
                  // The next message is from a different sender, so this is the last message from the target sender
                  isLastFromSender = true;
                }
              }


              /////////////////////////////////////////////
              // Set chat message seen
              if (!message.isSeen &&
                  message.receiverId != widget.receiverId) {
                ChatCubit.get(context).setChatMessageSeen(
                  receiverId: widget.receiverId,
                  messageId: message.messageId,
                );
              }

              // Update lastFetchedMessageTime when reaching the last message
              if (index == snapshot.data!.length - 1) {
                lastFetchedMessageTime = message.timeSent;
              }


              return Column(
                children: [
                  if (index == 0 ||
                      message.timeSent
                          .difference(snapshot.data![index - 1].timeSent)
                          .inHours >= 3)
                    ChatTimeCard(dateTime: message.timeSent),

                  if (message.receiverId == widget.receiverId)
                    Column(
                      children: [
                        MyMessageCard(
                          message: message,
                          isFirst: isFirst,
                          isLast: isLast, isLastForSeen: isLastForSeen,
                        ),
                      ],
                    ),
                  if (message.receiverId != widget.receiverId)
                    Column(
                      children: [
                     SenderMessageCard(
                          message: message,
                          isFirst: isFirst,
                          isLast: isLast,
                        ),
                      ],

                    ),

                  if (index == snapshot.data!.length - 1)
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.receiverId)
                          .snapshots(),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }

                        final bool isTyping =
                            userSnapshot.data?['isTyping'] ?? false;

                        // Scroll to the bottom when the FakeSenderMessageCard is displayed
                        if (isTyping) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            messageController.jumpTo(
                                messageController.position.maxScrollExtent);
                          });
                        }

                        return isTyping
                            ? FakeSenderMessageCard(
                          senderId: widget.receiverId,
                        )
                            : const SizedBox();
                      },
                    ),

                ],
              );
            },
          );
        },
      ),
    );
  }
}

class ChatTimeCard extends StatelessWidget {
  final DateTime dateTime;

  const ChatTimeCard({
    Key? key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        margin: const EdgeInsets.all(12),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          dateTime.chatDayTime,
          style: TextStyle(
            color: AppColorss.textColor1,
            fontWeight: FontWeight.normal,
            fontSize: 13,
            fontFamily: 'Baloo',
          ),
        ),
      ),
    );
  }
}


class FakeSenderMessageCard extends StatelessWidget {
  final String senderId;
  const FakeSenderMessageCard({super.key, required this.senderId});

  @override
  Widget build(BuildContext context) {
    return TypingMessageCard(
      // Customize the appearance of the fake message card as needed
      message: Message(
        messageId: 'fakeMessageId',
        isLiked: false,
        senderId: senderId,
        text: '... Typing',
        timeSent: DateTime.now(),
        isSeen: true,
        receiverId: 'receiverId',
        messageType: MessageType.text,
        repliedMessage: '',
        repliedTo: '',
        repliedMessageType: MessageType.text,
        senderName: '', // Replace with the actual receiverId
      ),
      isFirst: true, // You can customize this based on your design
      isLast: true, // It's the last message, so set it to true
    );
  }
}

