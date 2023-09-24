import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/routes/routes_manager.dart';
import '../../../data/models/stories_model.dart';
import '../../components/loader.dart';
import 'components/camera_appbar.dart';
import 'components/select_image_from_gallery_button.dart';

late List<CameraDescription> cameras;

class CameraStoryScreen extends StatefulWidget {
  final String receiverId;

  const CameraStoryScreen({Key? key, required this.receiverId}) : super(key: key);

  @override
  State<CameraStoryScreen> createState() => _CameraStoryScreenState();
}

class _CameraStoryScreenState extends State<CameraStoryScreen> {
  late CameraController _cameraController;
  late Future<void> _cameraValue;
  bool isFlashOn = false;
  bool isCameraFront = true;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    // Initialize the cameras list
    availableCameras().then((cameraList) {
      cameras = cameraList;
      _cameraController = CameraController(cameras[0], ResolutionPreset.high);
      _cameraValue = _cameraController.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(18, 32, 49, 1),
      // appBar: CameraAppBar(
      //   isFlashOn: isFlashOn,
      //   onFlashPressed: toggleFlash,
      // ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FutureBuilder<void>(
                  future: _cameraValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SizedBox(
                        width: double.infinity,
                        child: CameraPreview(_cameraController),
                      );
                    } else {
                      return const Loader();
                    }
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SelectImageFromGalleryButton(receiverId: widget.receiverId),
                        GestureDetector(
                          onTap: () {
                            if (!isRecording) takePhoto(context);
                          },
                          onLongPress: () async {
                            await _cameraController.startVideoRecording();
                            setState(() {
                              isRecording = true;
                            });
                          },
                          onLongPressUp: () async {
                            XFile videoPath = await _cameraController.stopVideoRecording();
                            setState(() {
                              isRecording = false;
                            });
                            if (!mounted) return;
                            navigateTo(context, Routes.sendingVideoViewRoute, arguments: {
                              'uId': widget.receiverId,
                              'path': videoPath.path,
                            });
                          },
                          child: cameraIcon(),
                        ),
                        GestureDetector(
                          onTap: toggleCameraFront,
                          child: const CircleAvatar(
                            radius: 30,
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Icon cameraIcon() {
    return isRecording
        ? const Icon(
      Icons.radio_button_on,
      color: Colors.red,
      size: 80,
    )
        : const Icon(
      Icons.panorama_fish_eye,
      size: 80,
      color: Colors.white,
    );
  }

  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
      isFlashOn ? _cameraController.setFlashMode(FlashMode.torch) : _cameraController.setFlashMode(FlashMode.off);
    });
  }

  void toggleCameraFront() {
    setState(() {
      isCameraFront = !isCameraFront;
      isCameraFront
          ? _cameraController = CameraController(cameras[0], ResolutionPreset.high)
          : _cameraController = CameraController(cameras[1], ResolutionPreset.high);
      _cameraValue = _cameraController.initialize();
    });
  }

  void takePhoto(BuildContext context) async {
    XFile file = await _cameraController.takePicture();

    // Get the current user ID
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String? userId = user?.uid;

    // Create a reference to the "stories" collection in the user's Firestore collection
    CollectionReference storiesCollection =
    FirebaseFirestore.instance.collection('users').doc(userId).collection('stories');

    // Generate a unique story ID (you can use your own logic here)
    String storyId = DateTime.now().millisecondsSinceEpoch.toString();

    // Create a new StoryModel instance
    StoryModel story = StoryModel(
      storyId: storyId,
      storyUploaderId: userId ?? '',
      storyUploaderName: '', // Add the user's name
      storyUploaderProfilePic: '', // Add the user's profile picture URL
      timestamp: DateTime.now(),
      imageUrl: file.path,
    );

    // Save the story to the "stories" collection
    await storiesCollection.doc(storyId).set(story.toMap());

    if (!mounted) return;
    navigateTo(context, Routes.sendingImageViewRoute, arguments: {
      'path': file.path,
      'uId': widget.receiverId,
    });
  }


  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
