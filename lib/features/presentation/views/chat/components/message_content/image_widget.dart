import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import 'package:message_me_app/features/presentation/views/chat/components/message_content/time_sent_widget.dart';
import '../../../../../domain/entities/message.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  final Message message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: InkWell(
        onTap: () {
          _openFullScreenImage(context);
        },
        child: Hero(
          tag: message.text.hashCode, // Use a unique identifier for the Hero tag
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: 160,
                  imageUrl: message.text,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const SizedBox(),
                ),
                // Positioned(
                //   bottom: 4,
                //   right: 8,
                //   child: Container(
                //     padding: EdgeInsets.only(top: 3, bottom: 0, right: 3, left: 3),
                //     decoration: BoxDecoration(
                //       color: AppColorss.myMessageColor.withOpacity(0.25),
                //       borderRadius: BorderRadius.circular(20)
                //     ),
                //
                //     child: TimeSentWidget(
                //       message: message,
                //       isMe: isMe,
                //       textColor: Colors.white,
                //     ),
                //   ),
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }


  void _openFullScreenImage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor:  AppColorss.primaryColor,
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
                          onTap: (){_SaveImage(context);},
                          child: Text(
                            "Save Image",
                            style: TextStyle(color: AppColorss.textColor1, fontSize: 15),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            FluentIcons.arrow_circle_down_24_regular,
                            color: AppColorss.iconsColors,
                          ),
                          onPressed: () {
                            _SaveImage(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),  // Shadow color
                        spreadRadius: 2,                      // Spread radius
                        blurRadius: 100,                        // Blur radius
                        offset: Offset(0, 3),                  // Offset in x and y direction
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height - 140,
                  child: Center(
                    child: Hero(
                      tag: message.text.hashCode,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: message.text,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => const CircularProgressIndicator(),
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
    );
  }

  void _SaveImage(BuildContext context) async {
    var cacheManager = DefaultCacheManager();
    var file = await cacheManager.getSingleFile(message.text);

      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
      final savedFile = await file.copy(imagePath);

      final result = await ImageGallerySaver.saveFile(savedFile.path);
      if (result['isSuccess']) {
            Fluttertoast.showToast(
              msg: 'Saved',
              toastLength: Toast.LENGTH_LONG,
              textColor: AppColorss.textColor1,
              backgroundColor: AppColorss.secondaryColor,
              gravity: ToastGravity.CENTER,
            );
      }else {
        Fluttertoast.showToast(
          msg: 'Fail to save Image',
          toastLength: Toast.LENGTH_LONG,
          textColor: AppColorss.textColor1,
          backgroundColor: AppColorss.secondaryColor,
          gravity: ToastGravity.CENTER,
        );
      }

  }






}
