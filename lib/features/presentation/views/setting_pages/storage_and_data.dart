import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:message_me_app/core/utils/constants/strings_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:system_info/system_info.dart';

import '../../../../core/utils/thems/my_colors.dart';

class StorageAndData extends StatefulWidget {
  const StorageAndData({Key? key}) : super(key: key);

  @override
  _StorageAndDataState createState() => _StorageAndDataState();
}

class _StorageAndDataState extends State<StorageAndData> {
  String appDirSize = 'Calculating...';
  String cacheDirSize = 'Calculating...';
  String totalStorage = 'Calculating...';
  String totalFreeSize = 'Calculating...';

  @override
  void initState() {
    super.initState();
    fetchStorageInfo();
    _getTotalStorageSize();
    _getFreeStorageSize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorss.primaryColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColorss.iconsColors),
        backgroundColor: AppColorss.primaryColor,
        title:  Text(AppStringss.storageAndDataInfo, style: TextStyle(color: AppColorss.textColor1),),
      ),
      body:
           SafeArea(
             child: Container(
               padding: const EdgeInsets.symmetric(vertical: 18),
               child: Column(
          children: [
                   if(Platform.isAndroid)
                   Container(
                       padding: const EdgeInsets.all(20),
                       width: MediaQuery.of(context).size.width - 18,
                       margin: const EdgeInsets.only(left: 20, right: 20, top: 2,bottom: 2),
                       decoration: BoxDecoration(
                           color: AppColorss.thirdColor,
                           borderRadius: BorderRadius.circular(12)
                       ),
                       child: Text('Total Device Storage: $totalStorage MB', style: TextStyle(color: AppColorss.textColor1, fontSize: 15)
                         ,)),
                   Container(
                       padding: const EdgeInsets.all(20),
                       width: MediaQuery.of(context).size.width - 18,
                       margin: const EdgeInsets.only(left: 20, right: 20, top: 2,bottom: 2),
                       decoration: BoxDecoration(
                           color: AppColorss.thirdColor,
                           borderRadius: BorderRadius.circular(12)
                       ),
                       child: Text('Application Directory Size: $appDirSize MB', style: TextStyle(color: AppColorss.textColor1, fontSize: 15),)),
                   Container(
                       padding: const EdgeInsets.all(20),
                       width: MediaQuery.of(context).size.width - 18,
                       margin: const EdgeInsets.only(left: 20, right: 20, top: 2,bottom: 2),
                       decoration: BoxDecoration(
                           color: AppColorss.thirdColor,
                           borderRadius: BorderRadius.circular(12)
                       ),
                       child: Text('Cache Directory Size: $cacheDirSize MB', style: TextStyle(color: AppColorss.textColor1, fontSize: 15),)),
                   if(Platform.isAndroid)
                   Container(
                       padding: const EdgeInsets.all(20),
                       width: MediaQuery.of(context).size.width - 18,
                       margin: const EdgeInsets.only(left: 20, right: 20, top: 2,bottom: 2),
                       decoration: BoxDecoration(
                           color: AppColorss.thirdColor,
                           borderRadius: BorderRadius.circular(12)
                       ),
                       child: Text('Total Free Size: $totalFreeSize MB', style: TextStyle(color: AppColorss.textColor1 ,fontSize: 15),)),
                   const SizedBox(height: 20),
                   const Spacer(),
                   SizedBox(
                     height: 50, width: 350,
                     child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                           backgroundColor: AppColorss.myMessageColor,
                           shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(12.0))
                       ),
                       onPressed: () {
                        clearCachedData();
                       },
                      child: const Text('Clear Cached Data', style: TextStyle(color: Colors.white, fontSize: 17),),
                  ),
                   ),
          ],
        ),
             ),
           )
    );
  }

  Future<void> fetchStorageInfo() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = await getTemporaryDirectory();

      final appDirSizeInt = await _getDirectorySize(appDir);
      final cacheDirSizeInt = await _getDirectorySize(cacheDir);

      final totalStorageSizeInt = await _getTotalStorageSize();
      final totalFreeSizeInt = await _getFreeStorageSize();

      setState(() {

        appDirSize = (appDirSizeInt / (1024 * 1024)).toStringAsFixed(2);
        cacheDirSize = (cacheDirSizeInt / (1024 * 1024)).toStringAsFixed(2);
        totalStorage = (totalStorageSizeInt / (1024 * 1024)).toStringAsFixed(2);
        totalFreeSize = (totalFreeSizeInt / (1024 * 1024)).toStringAsFixed(2);
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching storage information: $e');
      }
    }
  }

  Future<int> _getDirectorySize(Directory dir) async {
    int size = 0;

    try {
      if (await dir.exists()) {
        final files = dir.listSync(recursive: true);

        for (var file in files) {
          if (file is File) {
            size += await file.length();
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error calculating directory size: $e');
      }
    }

    return size;
  }

  Future<int> _getTotalStorageSize() async {
    try {
      final sysInfo = SysInfo.getTotalPhysicalMemory();
      final totalMemory = sysInfo;
      return totalMemory;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching total storage: $e');
      }
    }
    return 0;
  }


  Future<int> _getFreeStorageSize() async {
    try {
      final sysInfo = SysInfo.getFreePhysicalMemory();
      final totalMemory = sysInfo;
      return totalMemory;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching total storage: $e');
      }
    }
    return 0;
  }

  Future<void> clearCachedData() async {
    try {
      final cacheDir = await getTemporaryDirectory();
      final cacheDirFiles = cacheDir.listSync();

      for (var file in cacheDirFiles) {
        if (file is File) {
          await file.delete();
        }
      }

      setState(() {
        cacheDirSize = '0.00'; // Reset the cache directory size
      });

      // Provide feedback to the user that the cache has been cleared

          Fluttertoast.showToast(
            msg: 'Cache Cleared',
            toastLength: Toast.LENGTH_LONG,
            textColor: AppColorss.textColor1,
            backgroundColor: AppColorss.thirdColor,
            gravity: ToastGravity.CENTER,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing cache: $e');
      }
    }
  }
}
