import 'package:message_me_app/core/services/firebase_fcm_token.dart';

import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.uId,
    required super.status,
    required super.profilePic,
    required super.phoneNumber,
    required super.isOnline,
    required super.groupId,
    required super.lastSeen,
    required super.fcmToken,
    required super.isTyping,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'status': status,
      'profilePic': profilePic,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'groupId': groupId,
      'isTyping': isTyping,
      'lastSeen': lastSeen.millisecondsSinceEpoch,
      'fcmToken' : FirebaseService.fcmToken
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fcmToken: map['fcmToken'] ?? '',
      name: map['name'] ?? '',
      uId: map['uId'] ?? '',
      status: map['status'] ?? '',
      profilePic: map['profilePic'] ?? '',
      phoneNumber: map['phoneNumber'],
      isOnline: map['isOnline'] ?? false,
      isTyping: map['isTyping'] ?? false,
      groupId: List<String>.from(map['groupId']),
      lastSeen: DateTime.fromMillisecondsSinceEpoch(map['lastSeen']),
    );
  }
}
