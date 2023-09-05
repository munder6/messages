import 'package:equatable/equatable.dart';

class StoryEntry extends Equatable {
  final String storyId;
  final String storyUploaderId;
  final String storyUploaderName;
  final String storyUploaderProfilePic;
  final DateTime timestamp;
  final String imageUrl;

  StoryEntry({
    required this.storyId,
    required this.storyUploaderId,
    required this.storyUploaderName,
    required this.storyUploaderProfilePic,
    required this.timestamp,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
    storyId,
    storyUploaderId,
    storyUploaderName,
    storyUploaderProfilePic,
    timestamp,
    imageUrl,
  ];
}
