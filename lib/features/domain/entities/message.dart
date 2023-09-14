import 'package:equatable/equatable.dart';

import '../../../core/enums/messge_type.dart';

class Message extends Equatable {
  final String senderId;
  final String receiverId;
  final String senderName;
  final String text;
  final String messageId;
  final DateTime timeSent;
  final bool isSeen;
  final MessageType messageType;
  final String repliedMessage;
  final String repliedTo;
  final MessageType repliedMessageType;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.messageId,
    required this.timeSent,
    required this.isSeen,
    required this.messageType,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
    required this.senderName,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      senderName: json['senderName'] as String,
      text: json['text'] as String,
      messageId: json['messageId'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(json['timeSent'] as int),
      isSeen: json['isSeen'] as bool,
      messageType: MessageType.values[json['messageType'] as int],
      repliedMessage: json['repliedMessage'] as String,
      repliedTo: json['repliedTo'] as String,
      repliedMessageType: MessageType.values[json['repliedMessageType'] as int],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'senderName': senderName,
      'text': text,
      'messageId': messageId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'isSeen': isSeen,
      'messageType': messageType.index,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.index,
    };
  }

  @override
  List<Object?> get props => [
    senderId,
    receiverId,
    text,
    messageId,
    timeSent,
    isSeen,
    messageType,
    repliedMessage,
    repliedTo,
    repliedMessageType,
    senderName,
  ];
}
