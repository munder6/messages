import 'package:equatable/equatable.dart';

class ContactChat extends Equatable {
  final String name;
  final String profilePic;
  final String contactId;
  final String lastMessage;
  final DateTime timeSent;
  final String phoneNumber;

  const ContactChat({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.lastMessage,
    required this.timeSent,
    required this.phoneNumber,
  });

  // Add a factory method to create a ContactChat object from JSON
  factory ContactChat.fromJson(Map<String, dynamic> json) {
    return ContactChat(
      name: json['name'] as String,
      profilePic: json['profilePic'] as String,
      contactId: json['contactId'] as String,
      lastMessage: json['lastMessage'] as String,
      timeSent: DateTime.parse(json['timeSent'] as String),
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  // Add a method to convert a ContactChat object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'lastMessage': lastMessage,
      'timeSent': timeSent.toIso8601String(),
      'phoneNumber': phoneNumber,
    };
  }

  @override
  List<Object?> get props => [
    name,
    profilePic,
    contactId,
    lastMessage,
    timeSent,
    phoneNumber,
  ];
}
