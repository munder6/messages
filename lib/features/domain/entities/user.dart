import 'package:equatable/equatable.dart';

import '../../../constanse/constans.dart';

class UserEntity extends Equatable {
  final String name;
  final String fcmToken;
  final String uId;
  final String status;
  final String profilePic;
  final String phoneNumber;
  final bool isOnline;
  final bool isTyping;
  final bool isEnglish;
  final List<String> groupId;
  final DateTime lastSeen;

  const UserEntity({
    required this.name,
    required this.fcmToken,
    required this.uId,
    required this.status,
    required this.profilePic,
    required this.phoneNumber,
    required this.isOnline,
    required this.groupId,
    required this.lastSeen,
    required this.isTyping,
    required this.isEnglish,
  });


  String get profileImageUrl => UserRepository.profilePicUrl ?? profilePic;




  UserEntity copyWith({
    String? name,
    String? fcmToken,
    String? uId,
    String? status,
    String? profilePic,
    String? phoneNumber,
    bool? isOnline,
    bool? isEnglish,
    bool? isTyping,
    List<String>? groupId,
    DateTime? lastSeen,
  }) {
    return UserEntity(
      name: name ?? this.name,
      fcmToken: fcmToken ?? this.fcmToken,
      uId: uId ?? this.uId,
      status: status ?? this.status,
      profilePic: profilePic ?? this.profilePic,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isOnline: isOnline ?? this.isOnline,
      groupId: groupId ?? this.groupId,
      lastSeen: lastSeen ?? this.lastSeen,
      isTyping: isTyping ?? this.isTyping,
      isEnglish: isEnglish ?? this.isEnglish,
    );
  }

  @override
  List<Object?> get props => [
    name,
    fcmToken,
    uId,
    status,
    profilePic,
    phoneNumber,
    isOnline,
    groupId,
    lastSeen,
    isTyping,
    isEnglish,
  ];
}
