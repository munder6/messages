import 'package:message_me_app/core/enums/messge_type.dart';
import 'package:message_me_app/features/domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required String senderId,
    required String receiverId,
    required String text,
    required String messageId,
    required DateTime timeSent,
    required bool isSeen,
    required MessageType messageType,
    required String repliedMessage,
    required String repliedTo,
    required MessageType repliedMessageType,
    required String senderName,
  }) : super(
    senderId: senderId,
    receiverId: receiverId,
    text: text,
    messageId: messageId,
    timeSent: timeSent,
    isSeen: isSeen,
    messageType: messageType,
    repliedMessage: repliedMessage,
    repliedTo: repliedTo,
    repliedMessageType: repliedMessageType,
    senderName: senderName,
  );

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'messageId': messageId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'isSeen': isSeen,
      'messageType': messageType.type,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.type,
      'senderName': senderName,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      text: map['text'] as String,
      messageId: map['messageId'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      isSeen: map['isSeen'] as bool,
      messageType: MessageType.values.firstWhere(
            (type) => type.type == map['messageType'],
        orElse: () => MessageType.text, // Default to a sensible value
      ),
      repliedMessage: map['repliedMessage'] as String,
      repliedTo: map['repliedTo'] as String,
      repliedMessageType: MessageType.values.firstWhere(
            (type) => type.type == map['repliedMessageType'],
        orElse: () => MessageType.text, // Default to a sensible value
      ),
      senderName: map['senderName'] as String,
    );
  }
}
