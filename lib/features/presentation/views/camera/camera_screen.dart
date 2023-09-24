import 'package:camera/camera.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/routes/routes_manager.dart';
import '../../components/loader.dart';
import 'components/select_image_from_gallery_button.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  final String receiverId;
  const CameraScreen({super.key, required this.receiverId,});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> _cameraValue;
  bool isFlashOn = false;
  bool isCameraFront = true;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    _cameraValue = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: CameraAppBar(
      //   isFlashOn: isFlashOn,
      //   onFlashPressed: toggleFlash,
      // ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [

                FutureBuilder(
                  future: _cameraValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SizedBox(
                        width: double.infinity,
                        child: Container(
                          height: MediaQuery.of(context).size.height ,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)
                          ),
                            child: CameraPreview(_cameraController)),
                      );
                    } else {
                      return const Loader();
                    }
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                       SizedBox(height: MediaQuery.of(context).size.height / 40),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: (){
                                toggleFlash();
                              },
                              icon: Icon( isFlashOn ? FluentIcons.flash_24_regular : FluentIcons.flash_off_24_regular)
                          ),
                          IconButton(
                              onPressed: (){
                               Navigator.pop(context);
                              },
                              icon: const Icon(EvaIcons.close, size: 30,)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         SelectImageFromGalleryButton(receiverId: widget.receiverId),
                        GestureDetector(
                          onTap: () {
                            if (!isRecording) takePhoto(context);
                          },
                          onLongPress: ()async {
                            await _cameraController.startVideoRecording();
                            setState(() {
                              isRecording =true;
                            });

                          },
                          onLongPressUp: () async{
                            XFile videoPath = await _cameraController.stopVideoRecording();
                            setState(() {
                              isRecording = false;
                            });
                            if(!mounted) return;
                            navigateTo(context, Routes.sendingVideoViewRoute, arguments: {
                              'uId' : widget.receiverId,
                              'path' : videoPath.path,
                            },);
                          },
                          child: cameraIcon(),
                        ),
                        GestureDetector(
                          onTap: toggleCameraFront,
                          child: const CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black38,
                            child: Icon(
                              Icons.flip_camera_ios_outlined,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }

  Icon cameraIcon() {
    return  Icon(
            Icons.radio_button_on,
            color: isRecording ? Colors.red : Colors.white,
            size: 80,
          );
  }

  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
    });
    isFlashOn
        ? _cameraController.setFlashMode(FlashMode.torch)
        : _cameraController.setFlashMode(FlashMode.off);
  }

  void toggleCameraFront() {
    setState(() {
      isCameraFront = !isCameraFront;
    });
    int cameraPos = isCameraFront ? 0 : 1;
    _cameraController =
        CameraController(cameras[cameraPos], ResolutionPreset.ultraHigh);
    _cameraValue = _cameraController.initialize();
  }

  void takePhoto(BuildContext context) async {
    XFile file = await _cameraController.takePicture();
    if(!mounted) return;
    navigateTo(context, Routes.sendingImageViewRoute, arguments: {
      'path': file.path,
      'uId' : widget.receiverId,
    });
  }



  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }
}
