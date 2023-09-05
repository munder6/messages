import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';

import '../../../../core/functions/navigator.dart';
import '../../../../core/shared/commen.dart';
import '../../../../core/utils/constants/strings_manager.dart';
import '../../../../core/utils/routes/routes_manager.dart';
import '../../controllers/auth_cubit/auth_cubit.dart';
import 'components/landing_image.dart';
import 'components/login_appbar.dart';

class LoginLoadingScreen extends StatelessWidget {
  const LoginLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SaveUserDataToFirebaseSuccessState) {
          navigateAndRemove(context, Routes.mainLayoutRoute);
        }
        if (state is SaveUserDataToFirebaseErrorState) {
          showSnackBar(context: context, content: 'content err');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColorss.primaryColor,
          appBar: LoginAppBar(
            title: Text(
              AppStrings.initializing,
              style: TextStyle(color: AppColorss.textColor1),
            ),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppStrings.pleaseWaitAMoment,
                  style: TextStyle(color: AppColorss.textColor1, fontSize: 15),
                ),
                const Spacer(),
                const LandingImage(),
                const Spacer(),
                CircularProgressIndicator(color: AppColorss.textColor1,),
                const SizedBox(height: 60),
              ],
            ),
          ),
        );
      },
    );
  }
}
