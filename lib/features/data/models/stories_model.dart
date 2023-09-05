import '../../domain/entities/stories.dart';

class StoryModel extends StoryEntry {
  StoryModel({
    required String storyId,
    required String storyUploaderId,
    required String storyUploaderName,
    required String storyUploaderProfilePic,
    required DateTime timestamp,
    required String imageUrl,
  }) : super(
    storyId: storyId,
    storyUploaderId: storyUploaderId,
    storyUploaderName: storyUploaderName,
    storyUploaderProfilePic: storyUploaderProfilePic,
    timestamp: timestamp,
    imageUrl: imageUrl,
  );

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      storyId: map['storyId'] ?? '',
      storyUploaderId: map['storyUploaderId'] ?? '',
      storyUploaderName: map['storyUploaderName'] ?? '',
      storyUploaderProfilePic: map['storyUploaderProfilePic'] ?? '',
      timestamp: map['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'])
          : DateTime.now(),
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storyId': storyId,
      'storyUploaderId': storyUploaderId,
      'storyUploaderName': storyUploaderName,
      'storyUploaderProfilePic': storyUploaderProfilePic,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'imageUrl': imageUrl,
    };
  }
}
