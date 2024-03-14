import 'dart:ui';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:message_me_app/features/presentation/views/chat/components/message_content/time_sent_widget.dart';
import '../../../../../../core/utils/thems/my_colors.dart';
import '../../../../../domain/entities/message.dart';

class VideoPlayerItem extends StatefulWidget {
  final Message message;
  final bool isMe;

  const VideoPlayerItem({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
    VideoPlayerController.network(widget.message.text)
      ..initialize().then((value) {
        videoPlayerController.setVolume(1);
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  void _togglePlay() {
    if (isPlay) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
    setState(() {
      isPlay = !isPlay;
    });
  }


  void _openFullScreenVideo() {
    Navigator.push(
        context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) {
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: Colors.black.withOpacity(0.5), // Adjust the opacity as needed
                    ),
                  ),
                  Center(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4 , sigmaY: 4), // Adjust the blur intensity as needed
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.close_rounded, color: AppColorss.iconsColors, size: 30,),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: (){_saveVideo();},
                                          child: Text(
                                            "Save Video",
                                            style: TextStyle(color: AppColorss.textColor1, fontSize: 15),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            FluentIcons.arrow_circle_down_24_regular,
                                            color: AppColorss.iconsColors,
                                          ),
                                          onPressed: () {
                                            _saveVideo();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                          Expanded(
                            child: GestureDetector(
                              onTap: _togglePlay,
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: AspectRatio(
                                    aspectRatio: videoPlayerController.value.aspectRatio,
                                    child: Container(
                                      child: VideoPlayer(videoPlayerController),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
              );}
      ),
  );
  }
  //
  // void _openFullScreenVideo() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => Scaffold(
  //         backgroundColor:  AppColorss.primaryColor,
  //         body: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: [
  //               SizedBox(height: 30),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   IconButton(
  //                     icon: Icon(Icons.close_rounded, color: AppColorss.iconsColors, size: 30,),
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                   Row(
  //                     children: [
  //                       InkWell(
  //                         onTap: (){_saveVideo;},
  //                         child: Text(
  //                           "Save video",
  //                           style: TextStyle(color: AppColorss.textColor1, fontSize: 15),
  //                         ),
  //                       ),
  //                       IconButton(
  //                         icon: Icon(
  //                           FluentIcons.arrow_circle_down_24_regular,
  //                           color: AppColorss.iconsColors,
  //                         ),
  //                         onPressed: () {
  //                           _saveVideo();
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               Container(
  //                 height: MediaQuery.of(context).size.height - 160,
  //                 decoration: BoxDecoration(
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.grey.withOpacity(0.5),  // Shadow color
  //                       spreadRadius: 2,                      // Spread radius
  //                       blurRadius: 100,                        // Blur radius
  //                       offset: Offset(0, 3),                  // Offset in x and y direction
  //                     ),
  //                   ],
  //                 ),
  //                 child: GestureDetector(
  //                   onTap: _togglePlay,
  //                   child: Center(
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(20),
  //                       child: AspectRatio(
  //                         aspectRatio: videoPlayerController.value.aspectRatio,
  //                         child: Container(
  //                           child: VideoPlayer(videoPlayerController),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openFullScreenVideo,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SizedBox(
          height: 260,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(videoPlayerController),
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: _togglePlay,
                      icon: Icon(
                        isPlay ? Icons.pause_circle : Icons.play_circle,
                        size: 40,
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   right: 4,
                  //   child: Container(
                  //     padding: const EdgeInsets.only(top: 3, bottom: 0, right: 3, left: 3),
                  //     decoration: BoxDecoration(
                  //         color: AppColorss.myMessageColor.withOpacity(0.25),
                  //         borderRadius: BorderRadius.circular(20)
                  //     ),
                  //
                  //     child: TimeSentWidget(
                  //       message: widget.message,
                  //       isMe: widget.isMe,
                  //       textColor: Colors.white,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

