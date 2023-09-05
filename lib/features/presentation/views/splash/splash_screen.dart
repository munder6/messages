import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import '/core/functions/navigator.dart';
import '/core/services/services_locator.dart' as di;
import '../../../../core/utils/routes/routes_manager.dart';
import '../../../data/data_source/auth/local/auth_local_data_source.dart';
import 'components/splash_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(milliseconds: 500), _goNext);
  }

  _goNext() {
    di.sl<BaseAuthLocalDataSource>().getUser() != null
        ? navigateAndRemove(context, Routes.mainLayoutRoute)
        : navigateAndRemove(context, Routes.landingRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(
        statusBarColor: AppColorss.primaryColor,
        statusBarIconBrightness:Brightness.light,
      ),
    );
    return  Scaffold(
      backgroundColor: AppColorss.primaryColor,
      body: const Column(
        children: [
          SplashIcon(),
          //BottomText(),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}


