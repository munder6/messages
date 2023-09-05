import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:message_me_app/core/enums/messge_type.dart';
import 'package:message_me_app/features/presentation/controllers/chat_cubit/chat_cubit.dart';
import 'recording_mic_widget.dart';
import 'package:path/path.dart' as pathHelper;
import '../../../../controllers/bottom_chat_cubit/bottom_chat_cubit.dart';
import 'package:flutter_sound/flutter_sound.dart';

class RecordingMic extends StatefulWidget {
  final String receiverId;
  const RecordingMic({Key? key, required this.receiverId}) : super(key: key);

  @override
  State<RecordingMic> createState() => _RecordingMicState();
}

class _RecordingMicState extends State<RecordingMic> {
  late FlutterSoundRecorder _soundRecorder;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomChatCubit, BottomChatState>(
      builder: (context, state) {
        BottomChatCubit cubit = BottomChatCubit.get(context);
        return Visibility(
          visible: !cubit.isShownSendButton,
          child: RecordingMicWidget(
            onVerticalScrollComplete: () {},
            onHorizontalScrollComplete: () {
              cancelRecord();
            },
            onLongPress: () {
              startRecording();
            },
            onLongPressCancel: () {
              stopRecording();
            },
            onSend: () {
              stopRecording();
            },
            onTapCancel: () {
              cancelRecord();
            },
          ),
        );
      },
    );
  }

  Future<void> startRecording() async {
    if (await _requestPermission()) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = DateTime.now().toString().replaceAll(" ", "_") + ".aac";
      final filePath = '${appDir.path}/$fileName';

      await _soundRecorder.openAudioSession();
      await _soundRecorder.startRecorder(
        toFile: filePath,
        codec: Codec.aacMP4,
      );
      setState(() {
        _isRecording = true;
      });
    }
  }

  Future<void> stopRecording() async {
    if (_isRecording) {
      final path = await _soundRecorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });

      final file = File(path!);

      if (await file.exists()) {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = pathHelper.basename(path);
        final savePath = '${appDir.path}/$fileName';

        await file.rename(savePath);

        ChatCubit.get(context).sendFileMessage(
          receiverId: widget.receiverId,
          messageType: MessageType.audio,
          file: File(savePath),
        );
      } else {
        print('Source file does not exist: $path');
      }
    }
  }

  Future<void> cancelRecord() async {
    if (_isRecording) {
      await _soundRecorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });
    }
  }

  Future<bool> _requestPermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  @override
  void dispose() {
    _soundRecorder.closeAudioSession();
    super.dispose();
  }
}
