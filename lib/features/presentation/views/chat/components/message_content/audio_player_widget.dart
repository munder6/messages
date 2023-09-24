import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import 'package:message_me_app/features/domain/entities/message.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:message_me_app/features/presentation/views/chat/components/message_content/time_sent_widget.dart';

class AudioPlayerWidget extends StatefulWidget {
  final Message message;
  final bool isMe;

  const AudioPlayerWidget({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget>
    with TickerProviderStateMixin {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration? totalDuration;
  Duration? newTiming;

  bool isPlaying = false;
  bool showTimeSentWidget = false; // Track the visibility of the TimeSentWidget

  void initAudio() {
    debugPrint("Audio Initialized");
    audioPlayer.play(UrlSource(widget.message.text));
    audioPlayer.getDuration().then((value) {
      debugPrint(value.toString());
    });
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        newTiming = event;
      });
    });
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
    });
  }

  void pauseAudio() {
    audioPlayer.pause();
  }

  void stopAudio() {
    audioPlayer.stop();
  }

  void seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              showTimeSentWidget = !showTimeSentWidget; // Toggle the visibility of the TimeSentWidget
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 5),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 25,
                      child: Lottie.asset("assets/images/Voice.json", repeat: false),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (isPlaying) {
                    pauseAudio();
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                  } else {
                    if (newTiming.toString() == "null") {
                      initAudio();
                    } else {
                      audioPlayer.resume();
                    }
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                  }
                },
                child: Icon(
                  isPlaying ? Icons.pause_outlined : Icons.play_arrow_rounded,
                  size: 40,
                  color: widget.isMe ? Colors.white : AppColorss.iconsColors,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            child: FlutterSlider(
                              handlerHeight: 16,
                              handlerWidth: 16,
                              values: [newTiming == null ? 0 : newTiming!.inMilliseconds.toDouble()],
                              min: 0,
                              max: totalDuration == null ? 10 : totalDuration!.inMilliseconds.toDouble(),
                              handler: FlutterSliderHandler(
                                decoration: BoxDecoration(
                                  color: widget.isMe ? Colors.white : AppColorss.iconsColors,
                                  shape: BoxShape.circle,
                                ),
                                child: Container(), // Empty container to make the handler circular
                              ),
                              trackBar: FlutterSliderTrackBar(
                                inactiveTrackBar: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColorss.audioNonActiveSlider,
                                ),
                                activeTrackBar: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: widget.isMe ? Colors.blue.withOpacity(0.2) : AppColorss.audioActiveSlider,
                                ),
                              ),
                              onDragging: (handlerIndex, lowerValue, upperValue) {
                                setState(() {
                                  seekAudio(Duration(milliseconds: lowerValue.toInt()));
                                });
                              },
                            ),
                          ),
                          Text(
                            newTiming == null ? "00:00" : formatDuration(newTiming!),
                            style:  TextStyle(color: widget.isMe ? Colors.white : AppColorss.textColor1 , fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    // AnimatedSize(
                    // //  vsync: this,
                    //   duration: Duration(milliseconds: 300),
                    //   curve: Curves.easeInOut,
                    //   child: showTimeSentWidget
                    //       ? TimeSentWidget(
                    //     message: widget.message,
                    //     isMe: widget.isMe,
                    //     textColor: Colors.white54,
                    //   )
                    //       : SizedBox.shrink(),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
