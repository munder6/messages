import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import '/core/extensions/time_extension.dart';
import '../../../../../../core/functions/date_converter.dart';
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
  int limit = 5;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    final bottomOffset = messageController.position.maxScrollExtent;
    messageController.animateTo(
      bottomOffset,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  void loadMoreMessages() {
    // Increase the limit when swiping up to load more messages
    setState(() {
      limit += 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          // Check if swiped up and load more messages
          if (details.primaryVelocity! < 0) {
            loadMoreMessages();
          }
        },
        child: StreamBuilder<List<Message>>(
          stream: ChatCubit.get(context)
              .getChatMessages(widget.receiverId, limit),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
            // Scroll to bottom
            SchedulerBinding.instance.addPostFrameCallback((_) {
              messageController.jumpTo(
                  messageController.position.maxScrollExtent);
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
                          AnimatedMessageCard(
                            message: message,
                            isFirst: isFirst,
                            isLast: isLast,
                          ),
                        ],
                      ),
                    if (message.receiverId != widget.receiverId)
                      Column(
                        children: [
                          AnimatedSenderMessageCard(
                            message: message,
                            isFirst: isFirst,
                            isLast: isLast,
                          ),
                        ],
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class AnimatedMessageCard extends StatefulWidget {
  final Message message;
  final bool isFirst;
  final bool isLast;

  const AnimatedMessageCard({
    required this.message,
    required this.isFirst,
    required this.isLast,
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedMessageCardState createState() => _AnimatedMessageCardState();
}

class _AnimatedMessageCardState extends State<AnimatedMessageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200), // Adjust duration as needed
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: MyMessageCard(
        message: widget.message,
        isFirst: widget.isFirst,
        isLast: widget.isLast,
      ),
    );
  }
}

class AnimatedSenderMessageCard extends StatefulWidget {
  final Message message;
  final bool isFirst;
  final bool isLast;

  const AnimatedSenderMessageCard({
    required this.message,
    required this.isFirst,
    required this.isLast,
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedSenderMessageCardState createState() =>
      _AnimatedSenderMessageCardState();
}

class _AnimatedSenderMessageCardState
    extends State<AnimatedSenderMessageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200), // Adjust duration as needed
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SenderMessageCard(
        message: widget.message,
        isFirst: widget.isFirst,
        isLast: widget.isLast,
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
