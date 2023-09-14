import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:message_me_app/theme_cubit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'core/services/firebase_fcm_token.dart';
import 'core/utils/thems/my_colors.dart';
import 'core/shared/bloc_observer.dart';
import 'core/utils/constants/strings_manager.dart';
import 'core/utils/routes/routes_manager.dart';
import 'core/services/services_locator.dart' as di;
import 'features/presentation/controllers/auth_cubit/auth_cubit.dart';
import 'features/presentation/controllers/bottom_chat_cubit/bottom_chat_cubit.dart';
import 'features/presentation/controllers/chat_background_cubit/chat_background_cubit.dart';
import 'features/presentation/controllers/chat_cubit/chat_cubit.dart';
import 'features/presentation/controllers/select_contact_cubit/select_contact_cubit.dart';
import 'features/presentation/views/camera/camera_screen.dart';
import 'firebase_options.dart';


Future<void> requestNotificationPermission() async {
  final PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    print('Notification permissions granted');
  } else if (status.isDenied) {
    print('Notification permissions denied');
  } else if (status.isPermanentlyDenied) {
    print('Notification permissions permanently denied');
    openAppSettings();
  }
}



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //
  // String? fcmToken = await FirebaseMessaging.instance.getToken();
  // FirebaseService.fcmToken = fcmToken ?? '';
  // print('FCM Token: ${FirebaseService.fcmToken}');
  //
  // FirebaseMessaging.instance.getToken().then((token) {
  //   print('The Token $token');
  // }).catchError((error) {
  //   print('Failed to get token: $error');
  // });
  //
  // FirebaseMessaging.instance.subscribeToTopic('chats').then((value) {
  //   print('Subscribed to topic: chats');
  // }).catchError((error) {
  //   print('Failed to subscribe to topic: $error');
  // });
  //
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Received a foreground message: ${message.messageId}');
  //
  //   if (!AppRoutes.isChatScreenActive) {
  //     Fluttertoast.showToast(
  //       msg: 'You Have a new message',
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.TOP,
  //     );
  //   }
  // });
  //
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   print('Opened app from background notification: ${message.messageId}');
  // });

   await requestNotificationPermission();

  Bloc.observer = MyBlocObserver();
  await di.init();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = WidgetsBinding.instance.window.platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;
    final SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
      statusBarColor: isDarkMode ? AppColorss.primaryColor : Colors.transparent,
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDarkMode ? AppColorss.thirdColor : Colors.transparent,
      systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      systemNavigationBarDividerColor: isDarkMode ? AppColorss.thirdColor : Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);



    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthCubit>()..getCurrentUser()),
        BlocProvider(create: (context) => di.sl<SelectContactCubit>()..getAllContacts()..getContactsOnMessageMe(),),
        BlocProvider(create: (context) => di.sl<ChatCubit>()),
        BlocProvider(create: (context) => di.sl<BottomChatCubit>()),
        BlocProvider(create: (context) => di.sl<ChatBackgroundCubit>()),
        BlocProvider(create: (context) => di.sl<ThemeCubit>()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: Routes.splashRoute,
      ),
    );
  }
}







